defmodule Memoize.Benchmarks.Cachex do
  alias Memoize.Benchmarks.Bench

  def test(n, counter) do
    Cachex.transaction!(:my_cache, [n], fn state ->
      case Cachex.get(state, n) do
	{:ok, nil} ->
          Bench.calc(n, counter)
          Cachex.set!(state, n, n)
          n
        {:ok, value} ->
          value
      end
    end)
  end
end
