# Benchmark

Benchmark run from 2020-08-30 07:43:09.205978Z UTC

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
    <td style="white-space: nowrap; text-align: right">4.68 K</td>
    <td style="white-space: nowrap; text-align: right">213.78 μs</td>
    <td style="white-space: nowrap; text-align: right">±23.59%</td>
    <td style="white-space: nowrap; text-align: right">210.83 μs</td>
    <td style="white-space: nowrap; text-align: right">319.30 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.24 K</td>
    <td style="white-space: nowrap; text-align: right">308.38 μs</td>
    <td style="white-space: nowrap; text-align: right">±18.94%</td>
    <td style="white-space: nowrap; text-align: right">302.81 μs</td>
    <td style="white-space: nowrap; text-align: right">444.05 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.93 K</td>
    <td style="white-space: nowrap; text-align: right">1080.89 μs</td>
    <td style="white-space: nowrap; text-align: right">±9.55%</td>
    <td style="white-space: nowrap; text-align: right">1094.11 μs</td>
    <td style="white-space: nowrap; text-align: right">1220.92 μs</td>
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
    <td style="white-space: nowrap;text-align: right">4.68 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.24 K</td>
    <td style="white-space: nowrap; text-align: right">1.44x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.93 K</td>
    <td style="white-space: nowrap; text-align: right">5.06x</td>
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
    <td style="white-space: nowrap; text-align: right">13.13 K</td>
    <td style="white-space: nowrap; text-align: right">76.19 μs</td>
    <td style="white-space: nowrap; text-align: right">±77.23%</td>
    <td style="white-space: nowrap; text-align: right">76.95 μs</td>
    <td style="white-space: nowrap; text-align: right">150.10 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">12.40 K</td>
    <td style="white-space: nowrap; text-align: right">80.66 μs</td>
    <td style="white-space: nowrap; text-align: right">±71.34%</td>
    <td style="white-space: nowrap; text-align: right">80.85 μs</td>
    <td style="white-space: nowrap; text-align: right">155.01 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">9.87 K</td>
    <td style="white-space: nowrap; text-align: right">101.31 μs</td>
    <td style="white-space: nowrap; text-align: right">±2510.95%</td>
    <td style="white-space: nowrap; text-align: right">90.50 μs</td>
    <td style="white-space: nowrap; text-align: right">167.32 μs</td>
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
    <td style="white-space: nowrap;text-align: right">13.13 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">12.40 K</td>
    <td style="white-space: nowrap; text-align: right">1.06x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">9.87 K</td>
    <td style="white-space: nowrap; text-align: right">1.33x</td>
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
