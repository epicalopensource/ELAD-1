# ELAD1_CONTROL hardening

`src/elad1_control.v` -> placed-and-routed sky130_fd_sc_hd macro, with LibreLane.

| File | Purpose |
|---|---|
| `ELAD1_CONTROL.v` | Wrapper: renames the top module to `ELAD1_CONTROL` (GDS cell = LEF macro = netlist = symbol name) |
| `config.json` | LibreLane configuration: 160 x 60 um, 50 MHz clock target, met1-met4, PDN straps on met4 only |
| `pin_order.cfg` | North side: status, ui_in, rst_n, clk, ena (faces the TT digital pins); south side: EN/CLR/HEN/AGG_CLK (faces the analog core) |
| `harden.sh` | Runs LibreLane, publishes the GDS to `../layout/`, LEF / netlist / metrics to `../macro/`, and regenerates `../synth/ELAD1_CONTROL.spice` from the hardened netlist |
| `check_ports.sh` | Checks that the generated `.subckt` ports are in the symbol's pin order |

Where the results live:

| Path | What |
|---|---|
| `layout/ELAD1_CONTROL.gds` | the layout. The flow runs DRC on it; `make tt-check` compares every placed ELAD1_CONTROL instance against it. The only copy of the GDS. |
| `macro/ELAD1_CONTROL.lef` | abstract view for placing the macro |
| `macro/ELAD1_CONTROL.nl.v` | hardened gate-level netlist (source of `synth/*.spice`) |
| `macro/metrics.json` | LibreLane run metrics |

LVS: the cell has no `schematic/ELAD1_CONTROL.sch`, so the flow does not run LVS on it; LibreLane's
netgen LVS (in the run reports) is the controller's LVS. The KLayout sky130 LVS deck cannot extract
the conb_1 tie cells, so do not add a schematic just to trigger it.

Run (EDA box, project folder; lock the GDS first): 
`git lfs lock cells/ELAD1_CONTROL/layout/ELAD1_CONTROL.gds && bash cells/ELAD1_CONTROL/harden/harden.sh`

After a run, re-verify: `bash cells/ELAD1_CONTROL/harden/check_ports.sh`, the gate-level test (284 checks)
on `macro/ELAD1_CONTROL.nl.v`, `bash flow/run.sh ELAD1_CONTROL` (DRC), `bash flow/run.sh ELAD1_CORE`
and `bash flow/run.sh tt_um_epicalopensource_elad1`.

Floorplan intent (TT 2x2 tile, 334.88 x 225.76 um): the macro sits just below the top edge,
under uo_out / ui_in / rst_n / clk / ena (x ~ 75-147 um); ELAD1_ANALOG_CORE below it; the ua pins
on the bottom edge (x ~ 56-152 um).
