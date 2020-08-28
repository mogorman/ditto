# Benchmark

Benchmark run from 2020-08-28 14:08:39.576381Z UTC

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
    <td style="white-space: nowrap">30 s</td>
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
    <td style="white-space: nowrap; text-align: right">6.41 K</td>
    <td style="white-space: nowrap; text-align: right">156.11 μs</td>
    <td style="white-space: nowrap; text-align: right">±17.53%</td>
    <td style="white-space: nowrap; text-align: right">155.51 μs</td>
    <td style="white-space: nowrap; text-align: right">216.96 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">5.74 K</td>
    <td style="white-space: nowrap; text-align: right">174.10 μs</td>
    <td style="white-space: nowrap; text-align: right">±14.57%</td>
    <td style="white-space: nowrap; text-align: right">173.56 μs</td>
    <td style="white-space: nowrap; text-align: right">241.08 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.29 K</td>
    <td style="white-space: nowrap; text-align: right">774.01 μs</td>
    <td style="white-space: nowrap; text-align: right">±10.99%</td>
    <td style="white-space: nowrap; text-align: right">798.01 μs</td>
    <td style="white-space: nowrap; text-align: right">916.21 μs</td>
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
    <td style="white-space: nowrap;text-align: right">6.41 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">5.74 K</td>
    <td style="white-space: nowrap; text-align: right">1.12x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.29 K</td>
    <td style="white-space: nowrap; text-align: right">4.96x</td>
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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">19.63 K</td>
    <td style="white-space: nowrap; text-align: right">50.94 μs</td>
    <td style="white-space: nowrap; text-align: right">±50.48%</td>
    <td style="white-space: nowrap; text-align: right">51.67 μs</td>
    <td style="white-space: nowrap; text-align: right">100.41 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">19.56 K</td>
    <td style="white-space: nowrap; text-align: right">51.12 μs</td>
    <td style="white-space: nowrap; text-align: right">±51.17%</td>
    <td style="white-space: nowrap; text-align: right">51.85 μs</td>
    <td style="white-space: nowrap; text-align: right">98.68 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">15.27 K</td>
    <td style="white-space: nowrap; text-align: right">65.47 μs</td>
    <td style="white-space: nowrap; text-align: right">±594.08%</td>
    <td style="white-space: nowrap; text-align: right">63.45 μs</td>
    <td style="white-space: nowrap; text-align: right">138.53 μs</td>
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
    <td style="white-space: nowrap;text-align: right">19.63 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">19.56 K</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">15.27 K</td>
    <td style="white-space: nowrap; text-align: right">1.29x</td>
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
    <td style="white-space: nowrap">ditto</td>
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
