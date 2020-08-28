defmodule Ditto.Benchmarks.Memoize do
  use Memoize
  alias Ditto.Benchmarks.Bench

  defmemo test(n, counter) do
    Bench.calc(n, counter)
    n
  end
end
