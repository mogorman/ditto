# Benchmark

Benchmark run from 2020-08-26 04:01:43.301242Z UTC

## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>Linux</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Intel(R) Core(TM) M-5Y71 CPU @ 1.20GHz</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">4</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">7.68 GB</td>
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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">4.53 K</td>
    <td style="white-space: nowrap; text-align: right">0.22 ms</td>
    <td style="white-space: nowrap; text-align: right">±23.03%</td>
    <td style="white-space: nowrap; text-align: right">0.22 ms</td>
    <td style="white-space: nowrap; text-align: right">0.33 ms</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.86 K</td>
    <td style="white-space: nowrap; text-align: right">1.17 ms</td>
    <td style="white-space: nowrap; text-align: right">±6.50%</td>
    <td style="white-space: nowrap; text-align: right">1.17 ms</td>
    <td style="white-space: nowrap; text-align: right">1.32 ms</td>
  </tr>
</table>
Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap;text-align: right">4.53 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.86 K</td>
    <td style="white-space: nowrap; text-align: right">5.29x</td>
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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap">272 B</td>
      <td>&nbsp;</td>
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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">13.50 K</td>
    <td style="white-space: nowrap; text-align: right">74.07 μs</td>
    <td style="white-space: nowrap; text-align: right">±74.48%</td>
    <td style="white-space: nowrap; text-align: right">74.94 μs</td>
    <td style="white-space: nowrap; text-align: right">145.75 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">10.79 K</td>
    <td style="white-space: nowrap; text-align: right">92.66 μs</td>
    <td style="white-space: nowrap; text-align: right">±2782.20%</td>
    <td style="white-space: nowrap; text-align: right">83.66 μs</td>
    <td style="white-space: nowrap; text-align: right">133.23 μs</td>
  </tr>
</table>
Comparison
<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap;text-align: right">13.50 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">10.79 K</td>
    <td style="white-space: nowrap; text-align: right">1.25x</td>
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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap">272 B</td>
      <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap">272 B</td>
    <td>1.0x</td>
  </tr>
</table>
<hr/>
