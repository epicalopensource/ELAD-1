# ELAD1_CONTROL hardening

`src/elad1_control.v` -> placed-and-routed sky130_fd_sc_hd macro, with LibreLane.

| File | Purpose |
|---|---|
| `ELAD1_CONTROL.v` | Wrapper: renames the top module to `ELAD1_CONTROL` (GDS cell = LEF macro = netlist = symbol name) |
| `config.json` | LibreLane configuration: 160 x 60 um, 50 MHz clock target, met1-met4, PDN straps on met4 only |
| `pin_order.cfg` | North side: status, ui_in, rst_n, clk, ena (faces the TT digital pins); south side: EN/CLR/HEN/AGG_CLK (faces the analog core) |
| `harden.sh` | Runs LibreLane, publishes `../macro/` and regenerates `../synth/ELAD1_CONTROL.spice` from the hardened netlist |

Run (EDA box, project folder): `bash cells/ELAD1_CONTROL/harden/harden.sh`

After a run, re-verify: gate-level test (284 checks) on `macro/ELAD1_CONTROL.nl.v`,
`bash flow/run.sh ELAD1_CORE` and `bash flow/run.sh tt_um_epicalopensource_elad1`.

Floorplan intent (TT 2x2 tile, 334.88 x 225.76 um): the macro sits just below the top edge,
under uo_out / ui_in / rst_n / clk / ena (x ~ 75-147 um); ELAD1_ANALOG_CORE below it; the ua pins
on the bottom edge (x ~ 56-152 um).
