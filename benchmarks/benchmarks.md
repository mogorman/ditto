# Benchmark

Benchmark run from 2020-08-28 13:57:22.229691Z UTC

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
    <td style="white-space: nowrap">memoize</td>
    <td style="white-space: nowrap; text-align: right">5.57 K</td>
    <td style="white-space: nowrap; text-align: right">179.50 μs</td>
    <td style="white-space: nowrap; text-align: right">±16.78%</td>
    <td style="white-space: nowrap; text-align: right">176.85 μs</td>
    <td style="white-space: nowrap; text-align: right">277.29 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.26 K</td>
    <td style="white-space: nowrap; text-align: right">306.80 μs</td>
    <td style="white-space: nowrap; text-align: right">±30.63%</td>
    <td style="white-space: nowrap; text-align: right">280.39 μs</td>
    <td style="white-space: nowrap; text-align: right">687.33 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.26 K</td>
    <td style="white-space: nowrap; text-align: right">790.56 μs</td>
    <td style="white-space: nowrap; text-align: right">±12.64%</td>
    <td style="white-space: nowrap; text-align: right">800.41 μs</td>
    <td style="white-space: nowrap; text-align: right">1086.86 μs</td>
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
    <td style="white-space: nowrap;text-align: right">5.57 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">3.26 K</td>
    <td style="white-space: nowrap; text-align: right">1.71x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">1.26 K</td>
    <td style="white-space: nowrap; text-align: right">4.4x</td>
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
    <td style="white-space: nowrap; text-align: right">17.99 K</td>
    <td style="white-space: nowrap; text-align: right">55.58 μs</td>
    <td style="white-space: nowrap; text-align: right">±57.02%</td>
    <td style="white-space: nowrap; text-align: right">55.42 μs</td>
    <td style="white-space: nowrap; text-align: right">139.72 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">16.95 K</td>
    <td style="white-space: nowrap; text-align: right">58.98 μs</td>
    <td style="white-space: nowrap; text-align: right">±62.42%</td>
    <td style="white-space: nowrap; text-align: right">58.95 μs</td>
    <td style="white-space: nowrap; text-align: right">148.91 μs</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">16.58 K</td>
    <td style="white-space: nowrap; text-align: right">60.32 μs</td>
    <td style="white-space: nowrap; text-align: right">±497.23%</td>
    <td style="white-space: nowrap; text-align: right">59.26 μs</td>
    <td style="white-space: nowrap; text-align: right">110.06 μs</td>
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
    <td style="white-space: nowrap;text-align: right">17.99 K</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">ditto</td>
    <td style="white-space: nowrap; text-align: right">16.95 K</td>
    <td style="white-space: nowrap; text-align: right">1.06x</td>
  </tr>
  <tr>
    <td style="white-space: nowrap">cachex</td>
    <td style="white-space: nowrap; text-align: right">16.58 K</td>
    <td style="white-space: nowrap; text-align: right">1.09x</td>
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
