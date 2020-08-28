# Benchmark

Benchmark run from 2020-08-28 15:12:57.311346Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>Linux</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">8</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">31.31 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.10.4</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">22.3</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">5 min</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">2 s</td>
  </tr>
</table>

## Statistics


__Input: read__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">6.63 K</td>
    <td style="white-space: nowrap; text-align: right">150.79 μs</td>
    <td style="white-space: nowrap; text-align: right">±24.02%</td>
    <td style="white-space: nowrap; text-align: right">148.96 μs</td>
    <td style="white-space: nowrap; text-align: right">209.53 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">5.52 K</td>
    <td style="white-space: nowrap; text-align: right">181.24 μs</td>
    <td style="white-space: nowrap; text-align: right">±20.40%</td>
    <td style="white-space: nowrap; text-align: right">178.81 μs</td>
    <td style="white-space: nowrap; text-align: right">248.23 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.04 K</td>
    <td style="white-space: nowrap; text-align: right">960.87 μs</td>
    <td style="white-space: nowrap; text-align: right">±27.28%</td>
    <td style="white-space: nowrap; text-align: right">883.36 μs</td>
    <td style="white-space: nowrap; text-align: right">2071.81 μs</td>
  </tr>
</table>
Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap;text-align: right">6.63 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">5.52 K</td>
    <td style="white-space: nowrap; text-align: right">1.2x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.04 K</td>
    <td style="white-space: nowrap; text-align: right">6.37x</td>
  </tr>
</table>
Memory Usage
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
      <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap">272 B</td>
      <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap">272 B</td>
    <td>1.0x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap">272 B</td>
    <td>1.0x</td>
  </tr>
</table>
<hr/>

__Input: write__

Run Time
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">19.36 K</td>
    <td style="white-space: nowrap; text-align: right">51.66 μs</td>
    <td style="white-space: nowrap; text-align: right">±85.33%</td>
    <td style="white-space: nowrap; text-align: right">52.31 μs</td>
    <td style="white-space: nowrap; text-align: right">97.63 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">19.02 K</td>
    <td style="white-space: nowrap; text-align: right">52.57 μs</td>
    <td style="white-space: nowrap; text-align: right">±87.36%</td>
    <td style="white-space: nowrap; text-align: right">53.04 μs</td>
    <td style="white-space: nowrap; text-align: right">100.98 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">11.77 K</td>
    <td style="white-space: nowrap; text-align: right">84.96 μs</td>
    <td style="white-space: nowrap; text-align: right">±3012.16%</td>
    <td style="white-space: nowrap; text-align: right">68.62 μs</td>
    <td style="white-space: nowrap; text-align: right">205.43 μs</td>
  </tr>
</table>
Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap;text-align: right">19.36 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">19.02 K</td>
    <td style="white-space: nowrap; text-align: right">1.02x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">11.77 K</td>
    <td style="white-space: nowrap; text-align: right">1.64x</td>
  </tr>
</table>
Memory Usage
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Memory</th>
      <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap">272 B</td>
      <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap">272 B</td>
    <td>1.0x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap">272 B</td>
    <td>1.0x</td>
  </tr>
</table>
<hr/>
