alias Ditto.Benchmarks.Bench

children = [
  {Cachex, name: :my_cache}
]

opts = [strategy: :one_for_one, name: Bench.Supervisor]
Supervisor.start_link(children, opts)

Benchee.run(
  %{
    "ditto" => fn input -> Bench.run(Ditto.Benchmarks.Ditto, input) end,
    "memoize" => fn input -> Bench.run(Ditto.Benchmarks.Memoize, input) end,
    "cachex" => fn input -> Bench.run(Ditto.Benchmarks.Cachex, input) end
  },
  inputs: %{
    #   # number of times per process
    #   # number of processes
    #   # number range for cached values
    "write" => {1, 10_000, 1_000_000_000_000},
    "read" => {100, 10_000, 1}
  },
  time: 100,
  memory_time: 2,
  before_scenario: fn input -> Bench.before_scenario(input) end,
  after_scenario: fn input -> Bench.after_scenario(input) end,
  formatters: [
    {Benchee.Formatters.HTML, file: "benchmarks/html/bench.html", auto_open: false},
    {Benchee.Formatters.Markdown, file: "benchmarks/benchmarks.md"},
    Benchee.Formatters.Console
  ]
)
