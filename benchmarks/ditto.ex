defmodule Ditto.Benchmarks.Ditto do
  use Ditto
  alias Ditto.Benchmarks.Bench

  defditto test(n, counter, nope \\ 5)

  defditto test(n, counter, %{something: 4, what: var}) do
    Bench.calc(n + 1 , counter)
    n
  end

  defditto test(n, counter, nope) do
    Bench.calc(n, counter)
    n
  end

  # defditto tarai(x, y, _z) when x <= y do
  #   y
  # end

  # defditto tarai(x, y, z) do
  #   tarai(tarai(x - 1, y, z), tarai(y - 1, z, x), tarai(z - 1, x, y))
  # end
end
