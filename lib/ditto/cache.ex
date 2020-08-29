defmodule Ditto.Cache do
  @moduledoc """
  The caching layer for ditto.

  """
  @cache_strategy Ditto.Application.cache_strategy()
  @max_waiters Application.get_env(:ditto, :max_waiters, 20)
  @waiter_sleep_ms Application.get_env(:ditto, :waiter_sleep_ms, 200)
  @enable_telemetry Application.get_env(:ditto, :enable_telemetry, false)

  @overflow_timeout Application.get_env(:ditto, :overflow_timeout, 5000)

  require Ditto.Conditional
  import Ditto.Conditional

  def cache_strategy() do
    @cache_strategy
  end

  def cache_name(module) do
    if function_exported?(module, :__dittoize_cache_name__, 0) do
      module.__dittoize_cache_name__
    else
      nil
    end
  end

  defp compare_and_swap(table, _key, :nothing, value) do
    :ets.insert_new(table, value)
  end

  defp compare_and_swap(table, _key, expected, :nothing) do
    num_deleted = :ets.select_delete(table, [{expected, [], [true]}])
    num_deleted == 1
  end

  defp compare_and_swap(table, _key, expected, value) do
    num_replaced = :ets.select_replace(table, [{expected, [], [{:const, value}]}])
    num_replaced == 1
  end

  defp set_result_and_get_waiter_pids(table, key, result, context) do
    runner_pid = self()

    [{^key, {:running, ^runner_pid, waiter_pids}} = expected] = :ets.lookup(table, key)

    if compare_and_swap(table, key, expected, {key, {:completed, result, context}}) do
      waiter_pids
    else
      # retry
      set_result_and_get_waiter_pids(table, key, result, context)
    end
  end

  defp delete_and_get_waiter_pids(table, key) do
    runner_pid = self()

    [{^key, {:running, ^runner_pid, waiter_pids}} = expected] = :ets.lookup(table, key)

    if compare_and_swap(table, key, expected, :nothing) do
      waiter_pids
    else
      # retry
      delete_and_get_waiter_pids(table, key)
    end
  end

  @map_type :ditto_map_type

  # :ets.select_replace/2 does not accept map type.
  # So normalize_key/1 convert map type to list type recursively.
  defp normalize_key(map) when is_map(map) do
    kvs = map |> Map.to_list() |> Enum.sort_by(fn {key, _} -> key end)

    xs =
      for {key, value} <- kvs do
        {normalize_key(key), normalize_key(value)}
      end

    [@map_type | xs]
  end

  defp normalize_key(key) when is_list(key) do
    for x <- key do
      normalize_key(x)
    end
  end

  defp normalize_key({}), do: {}
  # tuple optimization
  defp normalize_key({a}), do: {normalize_key(a)}
  defp normalize_key({a, b}), do: {normalize_key(a), normalize_key(b)}
  defp normalize_key({a, b, c}), do: {normalize_key(a), normalize_key(b), normalize_key(c)}

  defp normalize_key({a, b, c, d}),
    do: {normalize_key(a), normalize_key(b), normalize_key(c), normalize_key(d)}

  defp normalize_key(key) when is_tuple(key) do
    size = tuple_size(key)

    Enum.reduce(0..(size - 1), key, fn n, key ->
      value = elem(key, n)
      put_elem(key, n, normalize_key(value))
    end)
  end

  defp normalize_key(key) do
    key
  end

  def get_or_run(module, function, args, fun, opts \\ []) do
    cache_name = cache_name(module)

    case cache_name == module do
      true ->
        get_or_run_optimized(cache_name, {function, args}, fun, opts)

      false ->
        get_or_run_optimized(cache_name, {module, function, args}, fun, opts)
    end
  end

  def get_or_run_optimized(module, _cache, function, args, fun, opts \\ [])

  def get_or_run_optimized(module, cache, function, args, fun, opts) when not is_function(fun) do
    get_or_run_optimized(module, cache, function, args, fn -> fun end, opts)
  end

  def get_or_run_optimized(cache_name, key, fun, opts) do
    if_enabled(@enable_telemetry) do
      start = System.monotonic_time()
    else
      start = 0
    end

    key = normalize_key(key)
    table = @cache_strategy.tab(cache_name, key)

    if_enabled(@enable_telemetry) do
      record_metric(%{cache: table, key: key, status: :attempt})
    end

    do_get_or_run(table, key, fun, start, opts)
  end

  defp do_get_or_run(table, key, fun, start, opts) do
    case :ets.lookup(table, key) do
      [] ->
        do_run(table, key, fun, start, opts)

      # running
      [{^key, {:running, runner_pid, waiter_pids}} = expected] ->
        do_already_running(table, key, runner_pid, waiter_pids, expected, fun, start, opts)

      # completed
      [{^key, {:completed, value, context}}] ->
        do_already_ran(table, key, value, context, start, opts)
    end
  end

  defp do_run(table, key, fun, start, opts) do
    # not started
    # calc
    runner_pid = self()

    if compare_and_swap(table, key, :nothing, {key, {:running, runner_pid, []}}) do
      if_enabled(@enable_telemetry) do
        record_metric(%{cache: table, key: key, start: start, status: :miss})
      end

      try do
        fun.()
      else
        result ->
          context = @cache_strategy.cache(table, key, result, opts)
          waiter_pids = set_result_and_get_waiter_pids(table, key, result, context)

          Enum.each(waiter_pids, fn pid ->
            send(pid, {self(), :completed})
          end)

          do_get_or_run(table, key, fun, start, opts)
      rescue
        error ->
          # the status should be :running
          waiter_pids = delete_and_get_waiter_pids(table, key)

          Enum.each(waiter_pids, fn pid ->
            send(pid, {self(), :failed})
          end)

          reraise error, System.stacktrace()
      end
    else
      do_get_or_run(table, key, fun, start, opts)
    end
  end

  def do_already_running(table, key, runner_pid, waiter_pids, expected, fun, start, opts) do
    if_enabled(@enable_telemetry) do
      record_metric(%{cache: table, key: key, start: start, status: :wait})
    end

    max_waiters = Keyword.get(opts, :max_waiters, @max_waiters)
    waiters = length(waiter_pids)

    if waiters < max_waiters do
      waiter_pids = [self() | waiter_pids]

      if compare_and_swap(
           table,
           key,
           expected,
           {key, {:running, runner_pid, waiter_pids}}
         ) do
        ref = Process.monitor(runner_pid)

        receive do
          {^runner_pid, :completed} -> :ok
          {^runner_pid, :failed} -> :ok
          {:DOWN, ^ref, :process, ^runner_pid, _reason} -> :ok
        after
          @overflow_timeout -> :ok
        end

        Process.demonitor(ref, [:flush])
        # flush existing messages
        receive do
          {^runner_pid, _} -> :ok
        after
          0 -> :ok
        end
      end
    else
      waiter_sleep_ms = Keyword.get(opts, :waiter_sleep_ms, @waiter_sleep_ms)
      Process.sleep(waiter_sleep_ms)
    end

    do_get_or_run(table, key, fun, start, opts)
  end

  def do_already_ran(table, key, value, context, start, opts) do
    case @cache_strategy.read(table, key, value, context) do
      :retry ->
        if_enabled(@enable_telemetry) do
          record_metric(%{cache: table, key: key, start: start, status: :stale})
        end

        do_get_or_run(table, key, fun, start, opts)

      :ok ->
        if_enabled(@enable_telemetry) do
          record_metric(%{cache: table, key: key, start: start, status: :hit})
        end

        value
    end
  end

  def invalidate() do
    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.invalidate() end, %{
        cache: :all,
        key: {:all},
        status: :invalidate
      })
    else
      @cache_strategy.invalidate()
    end
  end

  def invalidate(module) do
    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.invalidate(module) end, %{
        cache: module,
        key: {module},
        status: :invalidate
      })
    else
      @cache_strategy.invalidate(module)
    end
  end

  def invalidate(module, function) do
    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.invalidate(module, function) end, %{
        cache: module,
        key: {module, function},
        status: :invalidate
      })
    else
      @cache_strategy.invalidate(module, function)
    end
  end

  def invalidate(module, function, arguments) do
    arguments = normalize_key(arguments)

    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.invalidate(module, function, arguments) end, %{
        cache: module,
        key: {module, function, arguments},
        status: :invalidate
      })
    else
      @cache_strategy.invalidate(module, function, arguments)
    end
  end

  def garbage_collect() do
    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.garbage_collect() end, %{
        cache: :all,
        status: :garbage_collect
      })
    else
      @cache_strategy.garbage_collect()
    end
  end

  def garbage_collect(module) do
    if_enabled(@enable_telemetry) do
      time_metric_and_count(fn -> @cache_strategy.garbage_collect(module) end, %{
        cache: module,
        status: :garbage_collect
      })
    else
      @cache_strategy.garbage_collect(module)
    end
  end

  if @enable_telemetry do
    defp time_metric_and_count(fun, metric) do
      start = System.monotonic_time()
      record_metric(metric)
      result = fun.()

      metric
      |> Map.put(:start, start)
      |> Map.put(:count, result)
      |> record_metric()

      result
    end

    defp record_metric(%{start: start} = metric) do
      duration = System.monotonic_time() - start

      :telemetry.execute(
        [:ditto, :cache, :stop],
        Map.put(metric, :duration, duration)
      )
    end

    defp record_metric(metric) do
      :telemetry.execute([:ditto, :cache, :start], metric)
    end
  end
end
