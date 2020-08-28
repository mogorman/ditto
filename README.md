# Ditto

A memoization macro.

The application available in [hex.pm](https://hex.pm/packages/ditto).

## Requirement

- Elixir 1.5 or later.
- Erlang/OTP 20 or later.

## Installation

Add `:ditto` to your `mix.exs` dependencies:

```elixir
defp deps do
  [{:ditto, "~> 0.1"}]
end
```

## How to use ditto

If you want to cache a function, `use Ditto` on the module and change `def` to `defditto`.

for example:

```elixir
defmodule Fib do
  def fibs(0), do: 0
  def fibs(1), do: 1
  def fibs(n), do: fibs(n - 1) + fibs(n - 2)
end
```

this code changes to:

```elixir
defmodule Fib do
  use Ditto
  defditto fibs(0), do: 0
  defditto fibs(1), do: 1
  defditto fibs(n), do: fibs(n - 1) + fibs(n - 2)
end
```

If a function defined by `defditto` raises an error, the result is not cached and one of waiting processes will call the function.

## Exclusive

A caching function that is defined by `defditto` is never called in parallel.

```elixir
defmodule Calc do
  use Ditto
  defditto calc() do
    Process.sleep(1000)
    IO.puts "called!"
  end
end

# call `Calc.calc/0` in parallel using many processes.
for _ <- 1..10000 do
  Process.spawn(fn -> Calc.calc() end, [])
end

# but, actually `Calc.calc/0` is called only once.
```

## Invalidate

If you want to invalidate cache, you can use `Ditto.invalidate/{0-3}`.

```elixir
# invalidate a cached value of `Fib.fibs(0)`.
Ditto.invalidate(Fib, :fibs, [0])

# invalidate all cached values of `Fib.fibs/1`.
Ditto.invalidate(Fib, :fibs)

# invalidate all cached values of `Fib` module.
Ditto.invalidate(Fib)

# invalidate all cached values.
Ditto.invalidate()
```

Notice: `Ditto.invalidate/{0-2}`'s complexity is linear. Therefore, it takes a long time if `Ditto` has many cached values.

## Caching Partial Arguments

If you want to cache with partial arguments, use `Ditto.Cache.get_or_run/2` directly.

```elixir
defmodule Converter do
  def convert(unique_key, data) do
    Ditto.Cache.get_or_run({__MODULE__, :resolve, [unique_key]}, fn ->
      do_convert(data)
    end)
  end
end
```

## Cache Strategy

Cache strategy is a behaviour to management cached values.

By default, the caching strategy is `Ditto.CacheStrategy.Default`.

If you want to change the caching strategy, configure `:cache_strategy` in `:ditto` application.

```elixir
config :ditto,
  cache_strategy: Ditto.CacheStrategy.Eviction
```

WARNING: A caching strategy module is determined at *compile time*. It mean you **MUST** recompile `ditto` module when you change the caching strategy.

`ditto` provides below caching strategies.

- `Ditto.CacheStrategy.Default`
- `Ditto.CacheStrategy.Eviction`

## Cache Strategy - Ditto.CacheStrategy.Default

Default caching strategy.
It provides only simple and fast features.

Basically, cached values are not collected automatically.
To collect cached values, call `invalidate/{0-4}`, call `garbage_collect/0` or specify `:expires_in` with `defditto`.

### Expiration

If you want to invalidate the cache after a certain period of time, you can use `:expires_in`.

```elixir
defmodule Api do
  use Ditto
  defditto get_config(), expires_in: 60 * 1000 do
    call_external_api()
  end
end
```

The cached value is invalidated in the first `get_config/0` function call after `expires_in` milliseconds have elapsed.

To collect expired values, you can use `garbage_collect/0`. It collects all expired values. Its complexity is linear.

## Cache Strategy - Ditto.CacheStrategy.Eviction

`Ditto.CacheStrategy.Eviction` is one of caching strategy.
It provides many features, but slower than `Ditto.CacheStrategy.Default`.

The strategy is, basically, if cached memory size is exceeded `max_threshold`, *unused* cached values are collected until memory size falls below `min_threshold`.

To use `Ditto.CacheStrategy.Eviction`, configure `:cache_strategy` as below:

```elixir
config :ditto,
  cache_strategy: Ditto.CacheStrategy.Eviction

config :ditto, Ditto.CacheStrategy.Eviction,
  min_threshold: 5_000_000,
  max_threshold: 10_000_000
```

### Permanently

If `:permanent` option is specified with `defditto`, the value won't be collected automatically.
If you want to remove the value, call `invalidate/{0-3}`.

```elixir
defmodule Json do
  use Ditto
  defditto get_json(filename), permanent: true do
    filename |> File.read!() |> Poison.decode!()
  end
end
```

Notice the permanented value includes in used memory size. So you should adjust `min_threshold` value.

### Expiration

If `:expires_in` option is specified with `defditto`, the value will be collected after `:expires_in` milliseconds.
To be exact, when the `read/3` function is called with any arguments, all expired values will be collected.

```elixir
defmodule Api do
  use Ditto
  defditto get_config(), expires_in: 60 * 1000 do
    call_external_api()
  end
end
```

You can both specify `:permanent` and `:expires_in`.
In the case, the cached value is not collected by `garbage_collect/0` or memory size that exceed `max_threshold`, but after `:expires_in` milliseconds it is collected.

## Cache Strategy - Your Strategy

You can customize caching strategy.

```elixir
defmodule Ditto.CacheStrategy do
  @callback init() :: any
  @callback tab(any) :: atom
  @callback cache(any, any, Keyword.t) :: any
  @callback read(any, any, any) :: :ok | :retry
  @callback invalidate() :: integer
  @callback invalidate(any) :: integer
  @callback garbage_collect() :: integer
end
```

If you want to use a customized caching strategy, implement `Ditto.CacheStrategy` behaviour.

```elixir
defmodule YourAwesomeApp.ExcellentCacheStrategy do
  @behaviour Ditto.CacheStrategy

  def init() do
    ...
  end

  ...
end
```

Then, configure `:cache_strategy` in `:ditto` application.

```elixir
config :ditto,
  cache_strategy: YourAwesomeApp.ExcellentCacheStrategy
```

Notice `tab/1`, `read/3`, `invalidate/{0-1}`, `garbage_collect/0` are called concurrently.
`cache/3` is not called concurrently, but other functions are called concurrently while `cache/3` is called by a process.

### init/0

When application is started, `init/0` is called only once.

### tab/1

To determine which ETS tab to use, Ditto calls `tab/0`.

### cache/3

When new value is cached, `cache/3` will be called.
The first argument is `key` that is used as cache key.
The second argument is `value` that is calculated value by cache key.
The third argument is `opts` that is passed by `defditto`.

`cache/3` can return an any value that is called `context`.
`context` is stored to ETS.
And then, the context is passed to `read/3`'s third argument.

### read/3

When a value is looked up by a key, `read/3` will be called.
first and second arguments are same as `cache/3`.
The third argument is `context` that is created at `cache/3`.

`read/3` can return `:retry` or `:ok`.
If `:retry` is returned, retry the lookup.
If `:ok` is returned, return the `value`.

### invalidte/{0,1}

These functions are called from `Ditto.invalidate/{0-4}`.

### garbage_collect/0

The function is called from `Ditto.garbage_collect/0`.

## Waiter config

Normally, waiter processes are waiting at the end of the computing process using message passing. However, As the number of waiting processes increases, memory is consumed, so we limit this number of the waiters.

Number of waiter processes receiving message passing are configured as `config.exs` or `defditto` opts. (prior `defditto`)

With `config.exs`:

```elixir
config :ditto,
  max_waiter: 100,
  waiter_sleep_ms: 1000
```

With `defditto` opts:

```elixir
defditto foo(), max_waiter: 100, waiter_sleep_ms: 1000 do
  ...
end
```

- `:max_waiters`: Number of waiter processes receiving message passing. (default: 20)
- `:waiter_sleep_ms`: Time to sleep when the number of waiter processes exceeds `:max_waiters`. (default: 200)

## Internal

`Ditto` is using CAS (compare-and-swap) on ETS.

CAS is [now available](http://erlang.org/doc/man/ets.html#select_replace-2) in Erlang/OTP 20.

## Benchmarks

<!-- embedme benchmarks/benchmarks.md -->
