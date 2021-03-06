# Benchmark

Benchmark run from 2020-08-30 05:54:54.548982Z UTC

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
    <td style="white-space: nowrap">1.67 min</td>
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
    <td style="white-space: nowrap; text-align: right">4.67 K</td>
    <td style="white-space: nowrap; text-align: right">214.13 μs</td>
    <td style="white-space: nowrap; text-align: right">±21.43%</td>
    <td style="white-space: nowrap; text-align: right">211.05 μs</td>
    <td style="white-space: nowrap; text-align: right">373.04 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.12 K</td>
    <td style="white-space: nowrap; text-align: right">320.03 μs</td>
    <td style="white-space: nowrap; text-align: right">±38.06%</td>
    <td style="white-space: nowrap; text-align: right">313.00 μs</td>
    <td style="white-space: nowrap; text-align: right">505.69 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.90 K</td>
    <td style="white-space: nowrap; text-align: right">1114.44 μs</td>
    <td style="white-space: nowrap; text-align: right">±17.83%</td>
    <td style="white-space: nowrap; text-align: right">1102.27 μs</td>
    <td style="white-space: nowrap; text-align: right">1567.67 μs</td>
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
    <td style="white-space: nowrap;text-align: right">4.67 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.12 K</td>
    <td style="white-space: nowrap; text-align: right">1.49x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">0.90 K</td>
    <td style="white-space: nowrap; text-align: right">5.2x</td>
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
    <td style="white-space: nowrap; text-align: right">12.48 K</td>
    <td style="white-space: nowrap; text-align: right">80.11 μs</td>
    <td style="white-space: nowrap; text-align: right">±70.09%</td>
    <td style="white-space: nowrap; text-align: right">80.35 μs</td>
    <td style="white-space: nowrap; text-align: right">181.49 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">12.45 K</td>
    <td style="white-space: nowrap; text-align: right">80.33 μs</td>
    <td style="white-space: nowrap; text-align: right">±80.68%</td>
    <td style="white-space: nowrap; text-align: right">81.75 μs</td>
    <td style="white-space: nowrap; text-align: right">166.04 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">10.38 K</td>
    <td style="white-space: nowrap; text-align: right">96.33 μs</td>
    <td style="white-space: nowrap; text-align: right">±977.25%</td>
    <td style="white-space: nowrap; text-align: right">92.66 μs</td>
    <td style="white-space: nowrap; text-align: right">192.26 μs</td>
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
    <td style="white-space: nowrap;text-align: right">12.48 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">12.45 K</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">10.38 K</td>
    <td style="white-space: nowrap; text-align: right">1.2x</td>
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
