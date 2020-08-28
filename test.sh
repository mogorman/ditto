#!/bin/bash

set -ex

export DITTO_TEST_MODE="Ditto.CacheStrategy.Default"
cp config/default_config.exs config/config.exs
mix test

export DITTO_TEST_MODE="Ditto.CacheStrategy.Eviction"
cp config/eviction_config.exs config/config.exs
mix test

export DITTO_TEST_MODE="Ditto.CacheStrategy.Eviction_2"
cp config/eviction_config_2.exs config/config.exs
mix test

export DITTO_TEST_MODE="Ditto.WaiterConfig"
cp config/waiter_config.exs config/config.exs
mix test

rm config/config.exs
