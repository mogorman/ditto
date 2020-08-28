use Mix.Config

config :ditto, cache_strategy: Ditto.CacheStrategy.Eviction

config :ditto, Ditto.CacheStrategy.Eviction, max_threshold: :infinity
