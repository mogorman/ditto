defmodule Ditto do
  @moduledoc """
  #{File.read!("README.md")}
  """

  defmacro __using__(_args) do
    quote do
      @ditto_cache_name Enum.reduce(
                          Application.get_env(:ditto, :caches, []),
                          Ditto.Application.cache_strategy(),
                          fn mod, acc ->
                            if mod == __MODULE__ do
                              mod
                            else
                              acc
                            end
                          end
                        )
      import Ditto,
        only: [defditto: 1, defditto: 2, defditto: 3, defpditto: 1, defpditto: 2, defpditto: 3]

      @ditto_dittodefs []
      @ditto_origdefined %{}
      @before_compile Ditto

      def __ditto_cache_name__ do
        @ditto_cache_name
      end
    end
  end

  @doc ~S"""
  Define the dittoized function.

  Below code:

      defditto foo(0, y) do
        y
      end

      defditto foo(x, y) when x == 1 do
        y * z
      end

      defditto foo(x, y, z \\ 0) when x == 2 do
        y * z
      end

  is converted to:

      def foo(t1, t2) do
        Ditto.Cache.get_or_run_optimized({__MODULE__, :foo, [t1, t2]}, fn -> __foo_dittoize(t1, t2) end)
      end

      def foo(t1, t2, t3) do
        Ditto.Cache.get_or_run_optimized({__MODULE__, :foo, [t1, t2, t3]}, fn -> __foo_dittoize(t1, t2, t3) end)
      end

      def __foo_dittoize(0, y) do
        y
      end

      def __foo_dittoize(x, y) when x == 1 do
        y * z
      end

      def __foo_dittoize(x, y, z \\ 0) when x == 2 do
        y * z
      end

  """
  defmacro defditto(call, expr_or_opts \\ nil) do
    {opts, expr} = resolve_expr_or_opts(expr_or_opts)
    define(:def, call, opts, expr)
  end

  defmacro defpditto(call, expr_or_opts \\ nil) do
    {opts, expr} = resolve_expr_or_opts(expr_or_opts)
    define(:defp, call, opts, expr)
  end

  defmacro defditto(call, opts, expr) do
    define(:def, call, opts, expr)
  end

  defmacro defpditto(call, opts, expr) do
    define(:defp, call, opts, expr)
  end

  defp resolve_expr_or_opts(expr_or_opts) do
    cond do
      expr_or_opts == nil ->
        {[], nil}

      # expr_or_opts is expr
      Keyword.has_key?(expr_or_opts, :do) ->
        {[], expr_or_opts}

      # expr_or_opts is opts
      true ->
        {expr_or_opts, nil}
    end
  end

  defp define(method, call, _opts, nil) do
    # declare function
    quote do
      case unquote(method) do
        :def -> def unquote(call)
        :defp -> defp unquote(call)
      end
    end
  end

  defp define(method, call, opts, expr) do
    register_dittodef =
      case call do
        {:when, meta, [{origname, exprmeta, args}, right]} ->
          quote bind_quoted: [
                  expr: Macro.escape(expr, unquote: true),
                  origname: Macro.escape(origname, unquote: true),
                  exprmeta: Macro.escape(exprmeta, unquote: true),
                  args: Macro.escape(args, unquote: true),
                  meta: Macro.escape(meta, unquote: true),
                  right: Macro.escape(right, unquote: true)
                ] do
            require Ditto

            fun = {:when, meta, [{Ditto.__dittoname__(origname), exprmeta, args}, right]}
            @ditto_dittodefs [{fun, expr} | @ditto_dittodefs]
          end

        {origname, exprmeta, args} ->
          quote bind_quoted: [
                  expr: Macro.escape(expr, unquote: true),
                  origname: Macro.escape(origname, unquote: true),
                  exprmeta: Macro.escape(exprmeta, unquote: true),
                  args: Macro.escape(args, unquote: true)
                ] do
            require Ditto

            fun = {Ditto.__dittoname__(origname), exprmeta, args}
            @ditto_dittodefs [{fun, expr} | @ditto_dittodefs]
          end
      end

    fun =
      case call do
        {:when, _, [fun, _]} -> fun
        fun -> fun
      end

    deffun =
      quote bind_quoted: [
              fun: Macro.escape(fun, unquote: true),
              method: Macro.escape(method, unquote: true),
              opts: Macro.escape(opts, unquote: true)
            ] do
        {origname, from, to} = Ditto.__expand_default_args__(fun)
        dittoname = Ditto.__dittoname__(origname)

        for n <- from..to do
          args = Ditto.__make_args__(n)

          unless Map.has_key?(@ditto_origdefined, {origname, n}) do
            @ditto_origdefined Map.put(@ditto_origdefined, {origname, n}, true)
            case method do
              :def ->
                def unquote(origname)(unquote_splicing(args)) do
                  if __MODULE__ == @ditto_cache_name do
                    Ditto.Cache.get_or_run_optimized(
                      @ditto_cache_name,
                      {
                        unquote(origname),
                        [unquote_splicing(args)]
                      },
                      fn -> unquote(dittoname)(unquote_splicing(args)) end,
                      unquote(opts)
                    )
                  else
                    Ditto.Cache.get_or_run_optimized(
                      @ditto_cache_name,
                      {
                        __MODULE__,
                        unquote(origname),
                        [unquote_splicing(args)]
                      },
                      fn -> unquote(dittoname)(unquote_splicing(args)) end,
                      unquote(opts)
                    )
                  end
                end

              :defp ->
                defp unquote(origname)(unquote_splicing(args)) do
                  if __MODULE__ == @ditto_cache_name do
                    Ditto.Cache.get_or_run_optimized(
                      @ditto_cache_name,
                      {
                        unquote(origname),
                        [unquote_splicing(args)]
                      },
                      fn -> unquote(dittoname)(unquote_splicing(args)) end,
                      unquote(opts)
                    )
                  else
                    Ditto.Cache.get_or_run_optimized(
                      @ditto_cache_name,
                      {
                        __MODULE__,
                        unquote(origname),
                        [unquote_splicing(args)]
                      },
                      fn -> unquote(dittoname)(unquote_splicing(args)) end,
                      unquote(opts)
                    )
                  end
                end
            end
          end
        end
      end

    [register_dittodef, deffun]
  end

  # {:foo, 1, 3} == __expand_default_args__(quote(do: foo(x, y \\ 10, z \\ 20)))
  def __expand_default_args__(fun) do
    {name, args} = Macro.decompose_call(fun)

    is_default_arg = fn
      {:\\, _, _} -> true
      _ -> false
    end

    min_args = Enum.reject(args, is_default_arg)
    {name, length(min_args), length(args)}
  end

  # [] == __make_args__(0)
  # [{:t1, [], Elixir}, {:t2, [], Elixir}] == __make_args__(2)
  def __make_args__(0) do
    []
  end

  def __make_args__(n) do
    for v <- 1..n do
      {:"t#{v}", [], Elixir}
    end
  end

  def __dittoname__(origname), do: :"__#{origname}_dittoize"

  defmacro __before_compile__(_) do
    quote do
      @ditto_dittodefs
      |> Enum.reverse()
      |> Enum.map(fn {dittocall, expr} ->
        Code.eval_quoted({:defp, [], [dittocall, expr]}, [], __ENV__)
      end)
    end
  end
end
