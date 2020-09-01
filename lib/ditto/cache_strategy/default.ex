if Ditto.CacheStrategy.configured?(Ditto.CacheStrategy.Default) do
  defmodule Ditto.CacheStrategy.Default do
    @moduledoc """
    The default setting. has option ets per module, but defaults to all together
    """

    @behaviour Ditto.CacheStrategy

    @default_expires_in Application.get_env(:ditto, :expires_in, :infinity)

    @default_tags_enable Application.get_env(:ditto, :enable_tags, true)

    @ets_tab __MODULE__
    alias Ditto.Cache
    require Ditto.Conditional
    import Ditto.Conditional

    def init(opts) do
      if_enabled(@default_tags_enable) do
        init_tag_cache(tab(nil))
      end

      case Keyword.get(opts, :caches) do
        nil ->
          :ets.new(tab(nil), [:public, :set, :named_table, {:read_concurrency, true}])

        caches ->
          Enum.each(caches, fn cache ->
            :ets.new(tab(cache), [:public, :set, :named_table, {:read_concurrency, true}])
          end)
      end
    end

    defp init_tag_cache(module) do
      module
      |> Module.concat(Tags)
      |> :ets.new([:public, :duplicate_bag, :named_table, {:read_concurrency, true}])
    end

    def tab(nil) do
      @ets_tab
    end

    def tab(__MODULE__) do
      @ets_tab
    end

    def tab(module) do
      Module.concat(@ets_tab, module)
    end

    def cache(_module, _key, _value, opts) do
      IO.puts("opts #{inspect(opts)}")

      case Keyword.get(opts, :expires_in, @default_expires_in) do
        :infinity -> :infinity
        value -> System.monotonic_time(:millisecond) + value
      end
    end

    def read(_table, _key, _value, :infinity) do
      :ok
    end

    def read(table, key, _value, expired_at) do
      if System.monotonic_time(:millisecond) > expired_at do
        local_invalidate(table, key)
        :retry
      else
        :ok
      end
    end

    defp local_invalidate(table, key) do
      :ets.select_delete(table, [{{key, {:completed, :_, :_}}, [], [true]}])
    end

    def invalidate do
      # this is only place we have to run get_env, but given we are deleting everything its fine.
      Application.get_env(:ditto, :caches, [nil])
      |> Enum.reduce(0, fn cache, acc ->
        :ets.select_delete(tab(cache), [{{:_, {:completed, :_, :_}}, [], [true]}]) + acc
      end)
    end

    def invalidate(module) do
      cache_name = Cache.cache_name(module)

      cache_name
      |> tab()
      |> :ets.select_delete([{{key(cache_name, module), {:completed, :_, :_}}, [], [true]}])
    end

    def invalidate(module, function) do
      cache_name = Cache.cache_name(module)

      cache_name
      |> tab()
      |> :ets.select_delete([
        {{key(cache_name, module, function), {:completed, :_, :_}}, [], [true]}
      ])
    end

    def invalidate(module, function, args) do
      cache_name = Cache.cache_name(module)

      cache_name
      |> tab()
      |> :ets.select_delete([
        {{key(cache_name, module, function, args), {:completed, :_, :_}}, [], [true]}
      ])
    end

    def garbage_collect do
      expired_at = System.monotonic_time(:millisecond)
      # this is only place we have to run get_env, but given we are deleting everything its fine.
      Application.get_env(:ditto, :caches, [nil])
      |> Enum.reduce(0, fn cache, acc ->
        :ets.select_delete(tab(cache), [
          {{:_, {:completed, :_, :"$1"}},
           [{:andalso, {:"/=", :"$1", :infinity}, {:<, :"$1", {:const, expired_at}}}], [true]}
        ]) + acc
      end)
    end

    def garbage_collect(module) do
      expired_at = System.monotonic_time(:millisecond)

      cache_name = Cache.cache_name(module)

      cache_name
      |> tab()
      |> :ets.select_delete([
        {{key(cache_name, module), {:completed, :_, :"$1"}},
         [{:andalso, {:"/=", :"$1", :infinity}, {:<, :"$1", {:const, expired_at}}}], [true]}
      ])
    end

    # ets per module
    defp key(module_name, module_name) do
      {:_, :_}
    end

    defp key(_cache_name, module_name) do
      {module_name, :_, :_}
    end

    # ets per module
    defp key(module_name, module_name, function_name) do
      {function_name, :_}
    end

    defp key(_cache_name, module_name, function_name) do
      {module_name, function_name, :_}
    end

    # ets per module
    defp key(module_name, module_name, function_name, args) do
      {function_name, args}
    end

    defp key(_cache_name, module_name, function_name, args) do
      {module_name, function_name, args}
    end
  end
end
