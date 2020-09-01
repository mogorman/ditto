defmodule Ditto do
  @moduledoc """
  #{File.read!("README.md")}
  """

  # todo: add tags to the records put in default cache so that we can invalidate tags from normal invalidtate or vice versa

  defmacro __using__(_args) do
    quote do
      @cache_strategy Ditto.Application.cache_strategy()
      @ditto_cache_name Enum.reduce(
                          Application.get_env(:ditto, :caches, []),
                          @cache_strategy,
                          fn mod, acc ->
                            if mod == __MODULE__ do
                              mod
                            else
                              acc
                            end
                          end
                        )

      @ditto_table_name @cache_strategy.tab(@cache_strategy)

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

  # defp register_dittodef(call, expr) do
  #   case call do
  #     {:when, meta, [{origname, exprmeta, args}, right]} ->
  # 	IO.puts("ARGS ARE #{inspect(args)}")
  #       quote bind_quoted: [
  #         expr: Macro.escape(expr, unquote: true),
  #         origname: Macro.escape(origname, unquote: true),
  #         exprmeta: Macro.escape(exprmeta, unquote: true),
  #         args: Macro.escape(args, unquote: true),
  #         meta: Macro.escape(meta, unquote: true),
  #         right: Macro.escape(right, unquote: true)
  #       ] do
  #         require Ditto

  #         fun = {:when, meta, [{Ditto.__dittoname__(origname), exprmeta, args}, right]}
  #         @ditto_dittodefs [{fun, expr} | @ditto_dittodefs]
  #       end

  #     {origname, exprmeta, args} ->
  #       quote bind_quoted: [
  #         expr: Macro.escape(expr, unquote: true),
  #         origname: Macro.escape(origname, unquote: true),
  #         exprmeta: Macro.escape(exprmeta, unquote: true),
  #         args: Macro.escape(args, unquote: true)
  #       ] do
  #         require Ditto

  #         fun = {Ditto.__dittoname__(origname), exprmeta, args}
  #         @ditto_dittodefs [{fun, expr} | @ditto_dittodefs]
  #       end
  #   end
  # end

  defp define(method, call, opts, expr) do
    #    register_dittodef = register_dittodef(call, expr)
    IO.puts("DEFINED! CALL #{inspect(call)}")
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

    opts = opts || []

    deffun =
      quote bind_quoted: [
              call: Macro.escape(call, unquote: true),
              fun: Macro.escape(fun, unquote: true),
              method: Macro.escape(method, unquote: true),
              opts: Macro.escape(opts, unquote: true)
      ] do
      {_, _, ugh_args} = fun
        {origname, args} = Macro.decompose_call(fun)
        dittoname = Ditto.__dittoname__(origname)

	parsed_args = Enum.map(args, fn
	  {:\\, _location, [{name, _location, _value}, _ ]} -> name
	  {name, _location, _value} -> name
	end)

        tag_args =
          Enum.map(Keyword.get(opts, :tags, []), fn tag ->
            {tag, Enum.find_index(parsed_args, fn arg -> arg == tag end)}
          end)
	IO.puts("DEFINED2 CALL #{inspect(ugh_args)}")
	IO.puts("DEFINED3 CALL #{inspect(args)}")
	IO.puts("DEFINED4 CALL #{inspect(call)} ::::: #{inspect(parsed_args)}")
        case method do
          :def ->
            if __MODULE__ == @ditto_cache_name do
	      IO.puts("HERE")
              def unquote(call) do
#                final_args = [unquote_splicing(args)]
		IO.puts("DEFINED CALL #{inspect(call)}")
                # final_tags =
                #   Enum.reduce(unquote(tag_args), %{}, fn
                #     {tag_arg, nil}, acc ->
                #       Map.put(acc, tag_arg, nil)

                #     {tag_arg, pos}, acc ->
                #       Map.put(acc, tag_arg, Enum.at(final_args, pos, nil))
                #   end)

                Ditto.Cache.get_or_run_optimized(
                  @ditto_table_name,
                  {
                    unquote(origname), nil
#                    final_args
                  },
                  fn -> unquote(dittoname)(unquote_splicing([])) end,
                  Keyword.put(unquote(opts), :tags, final_tags)
                )
              end
            else
              def unquote(call) do
                final_args = [unquote_splicing(args)]

                final_tags =
                  Enum.reduce(unquote(tag_args), %{}, fn
                    {tag_arg, nil}, acc -> Map.put(acc, tag_arg, nil)
                    {tag_arg, pos}, acc -> Map.put(acc, tag_arg, Enum.at(final_args, pos))
                  end)

                Ditto.Cache.get_or_run_optimized(
                  @ditto_table_name,
                  {
                    __MODULE__,
                    unquote(origname),
                    [unquote_splicing(parsed_args)]
                  },
                  fn -> unquote(dittoname)(unquote_splicing(parsed_args)) end,
                  Keyword.put(unquote(opts), :tags, final_tags)
                )
              end
            end

          :defp ->
            if __MODULE__ == @ditto_cache_name do
              defp unquote(call) do
                final_args = [unquote_splicing(args)]

                final_tags =
                  Enum.reduce(unquote(tag_args), %{}, fn
                    {tag_arg, nil}, acc ->
                      Map.put(acc, tag_arg, nil)

                    {tag_arg, pos}, acc ->
                      Map.put(acc, tag_arg, Enum.at(final_args, pos, nil))
                  end)

                Ditto.Cache.get_or_run_optimized(
                  @ditto_table_name,
                  {
                    unquote(origname),
                    final_args
                  },
                  fn -> unquote(dittoname)(unquote_splicing(args)) end,
                  Keyword.put(unquote(opts), :tags, final_tags)
                )
              end
            else
              defp unquote(call) do
                final_args = [unquote_splicing(args)]

                final_tags =
                  Enum.reduce(unquote(tag_args), %{}, fn
                    {tag_arg, nil}, acc ->
                      Map.put(acc, tag_arg, nil)

                    {tag_arg, pos}, acc ->
                      Map.put(acc, tag_arg, Enum.at(final_args, pos, nil))
                  end)

                Ditto.Cache.get_or_run_optimized(
                  @ditto_table_name,
                  {
                    __MODULE__,
                    unquote(origname),
                    final_args
                  },
                  fn -> unquote(dittoname)(unquote_splicing(args)) end,
                  Keyword.put(unquote(opts), :tags, final_tags)
                )
              end
            end
        end
      end

    [register_dittodef, deffun]
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
