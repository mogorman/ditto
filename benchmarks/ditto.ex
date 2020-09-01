defmodule Ditto.Benchmarks.Ditto do
  use Ditto
  alias Ditto.Benchmarks.Bench

  # defditto test(n, counter, nope \\ 5)

  # defditto test(n, counter, %{something: 4, what: var, other: [4,5,6]} = a_thing), tags: [:n, :it_works] do
  #   Bench.calc(n + 1 , counter)
  #   n
  # end

  # defditto test(n, counter, nope) do
  #   Bench.calc(n, counter)
  #   n
  # end



  # defditto foo(x, y) when x == 0 do
  #   y
  # end

  # defditto foo(1, y) do
  #   y * 2
  # end

  # defditto foo(x, y, z \\ 5) when x == 2 do
  #   y * z
  # end

  def foo(x= mog0, y= mog1, %{sure: d \\ 4} ) when x == 2 do
    y * z
  end

  # defditto foo(x, y, z \\ 0) when x == 2 do
  #   y * z
  # end

  # defditto tarai(x, y, _z) when x <= y do
  #   y
  # end

  # defditto tarai(x, y, z) do
  #   tarai(tarai(x - 1, y, z), tarai(y - 1, z, x), tarai(z - 1, x, y))
  # end
end
