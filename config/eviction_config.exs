use Mix.Config

config :ditto, cache_strategy: Ditto.CacheStrategy.Eviction

config :ditto, Ditto.CacheStrategy.Eviction,
  min_threshold: 90000,
  max_threshold: 100_000
