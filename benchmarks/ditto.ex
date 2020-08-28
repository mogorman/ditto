defmodule Ditto.Benchmarks.Ditto do
  use Ditto
  alias Ditto.Benchmarks.Bench

  defditto test(n, counter) do
    Bench.calc(n, counter)
    n
  end
end
