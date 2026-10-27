<!---
This file is used to generate your project datasheet.
-->

## How it works

ELAD-1 (Epical Layout Analog Demonstrator) compares electrically identical analog
circuits that differ only in their physical layout. It contains:

- two NMOS current mirrors (grouped and common-centroid unit placement),
- two NMOS differential pairs (grouped and common-centroid),
- two resistor-loaded NMOS victim stages (baseline and with a contacted P+ guard ring)
  at equal distance from a shared substrate tap; the tap is disturbed either from ua[0]
  (read back on ua[2]) or by an on-chip aggressor that steers about 75 uA into it,
- a resistor heater beside the matching arrays for thermal-gradient experiments,
- an analog selector that routes the six analog pins to the active experiment,
  controlled by a registered digital controller with break-before-make switching.

## How to test

Select the experiment with ui_in[1:0] (00 idle, 01 mirror, 10 pair, 11 noise) and the
layout version with ui_in[2] (0 grouped, 1 common centroid), then pulse APPLY
(ui_in[7]). uo_out[0] (ACTIVE) acknowledges the routing.

- Mirror: force the reference current into ua[0], sense the reference node on ua[3],
  measure the output current on ua[4].
- Pair: tail gate voltage on ua[0], VIN+ on ua[1], VIN- on ua[2], drains on ua[3] and ua[4].
- Noise: victim gate bias on ua[1], baseline output on ua[3], guarded output on ua[4].
  Injector (DC): drive the substrate tap from ua[0] and read the tap on ua[2] (1 Gohm
  meter); step it 0, +50, +100 mV (never above +0.2 V) and record ua[3], ua[4]. The ratio
  of the two output changes is the guard ring's isolation.
  Aggressor (AC): ua[0] output off, enable with ui_in[4], rate with ui_in[6:5] (TT clock
  20-100 kHz with rate /2); read the steps on ua[3], ua[4] and the tap step on ua[2].
- Heater: DC source on ua[5]; enabled with ui_in[3] in mirror or pair mode only.

Operating contract: make the external source on ua[0] inactive before changing between
current-forcing (mirror) and voltage-forcing (pair) modes.

## External hardware

Tiny Tapeout demo board, precision current/voltage sources and a voltmeter or SMU.
