defmodule Ditto.Conditional do
  defmacro if_enabled(clause, do: expression) do
    var = Macro.expand(clause, __CALLER__)

    if var == true do
      quote do
        unquote(expression)
      end
    end
  end

  defmacro if_enabled(clause, do: expression, else: other_expression) do
    var = Macro.expand(clause, __CALLER__)

    if var == true do
      quote do
        unquote(expression)
      end
    else
      quote do
        unquote(other_expression)
      end
    end
  end
end
