# Tiny Tapeout support (`flow/tt/`)

This repository was created from Tiny Tapeout's analog template
([TinyTapeout/ttsky-analog-template](https://github.com/TinyTapeout/ttsky-analog-template)) and
the analog flow was added on top. Everything Tiny Tapeout reads is kept exactly where and how
TT expects it; the flow only adds folders TT ignores.

## Repository layout

| Path | Owner | What |
|---|---|---|
| `info.yaml` | TT (you fill it) | title, author, description, `top_module`, `tiles`, `analog_pins`, `uses_vapwr`, pinout |
| `src/project.v` | TT (kept in sync by `make tt-init`/`tt-rename`) | Verilog stub: `module <top_module>` with the TT ports |
| `docs/info.md` | TT (you write it) | datasheet text |
| `gds/<top_module>.gds` | **generated** by `make tt` | what TT builds the chip from; plain git (not LFS) |
| `lef/<top_module>.lef` | **generated** by `make tt` | pin-only abstract; plain git |
| `.github/workflows/gds.yaml`, `docs.yaml` | TT, **never edit** | TT's GDS/precheck/viewer and docs Actions |
| `README.md`, `LICENSE`, `test/` | TT | edit README to describe your design |
| `cells/<top_module>/layout/<top_module>.gds` | you (KLayout) | the top-level layout: TT pins, power stripes, tie-offs, your core placed inside |
| `cells/<core>/…` | you | your circuit(s): schematic, symbol, testbench, layout — fully verified by the flow |
| `flow/`, `ci/`, `Makefile`, `flow.conf`, `.github/workflows/analog-flow.yml` | flow | verification + TT export/checks |

The top module name appears in six places that must agree (info.yaml, project.v, the two file
names, the GDS top cell, the LEF macro). Only `make tt-init` / `make tt-rename` change it.

## Commands (EDA box, project folder)

| Command | Does |
|---|---|
| `make tt-init TOP=tt_um_<you>_<name>` | sets `top_module`, fixes `src/project.v`, creates `cells/<top>/layout/<top>.gds` from TT's template DEF (never overwrites) |
| `make tt` | runs the whole flow on every cell, exports `gds/` + `lef/`, runs `tt-check` — **the one command before committing a submission state** |
| `make tt-check` | TT rule check only (seconds) |
| `make tt-precheck` | Tiny Tapeout's own precheck code, locally (needs internet once) |
| `make tt-rename NEW=tt_um_<you>_<name>` | renames the project everywhere |

## What the generated top-level shell contains

Made from TT's template DEF for your `tiles`/`uses_vapwr` (vendored in `flow/tt/def/`):

* `prBoundary` (235/4) rectangle = the die (1x2: 161.00 x 225.76 um; 2x2: 334.88 x 225.76 um;
  the 3.3 V variants are narrower)
* all 51 template pins on met4 (drawing + `met4.pin` + `met4.label` text), exact positions —
  **never move or resize them**
* power stripes on met4, 2 um wide, from 5 um above the bottom to 5 um below the top:
  `VGND` at x = 1 um, `VDPWR` at x = 4 um (`VAPWR` at x = 7 um when `uses_vapwr: true`)
* every `uo_out`, `uio_out`, `uio_oe` pin tied to `VGND` (met4 stub, via3, met3 bus), as TT's
  analog spec requires. To drive an output yourself, delete that pin's stub and connect it.
* the `ua[...]` pins left unconnected: wire `ua[0]`, `ua[1]`, … in order, then set
  `analog_pins` and describe each used pin in `info.yaml`'s pinout. `make tt-wire PIN=ua[0]`
  draws a 10 um met4 lead from a pin to start from.
* **`analog_pins` must be at least 1.** With 0, TT's precheck treats the project as digital,
  checks it against the digital template (no `ua` pins) and fails with "Unexpected pin ua[0..7]".

## What `tt-check` enforces

| Check | Rule source |
|---|---|
| info.yaml filled, `tt_um_` name, tiles 1x2/2x2, analog_pins 1..6, VAPWR needs an analog pin | TT docs check + precheck |
| `docs/info.md` no longer contains the template's placeholder sentences | TT docs check |
| `src/project.v` module = `top_module`; `VAPWR` port present exactly when `uses_vapwr` | TT spec + power pin check |
| `gds/` and `lef/` are exactly the export of the verified `cells/<top>` layout; no KLayout context cell | flow (TT receives what was verified) |
| one top cell; die = template; prBoundary; no met5; no `#`/`/` in cell names | TT precheck |
| template pins exact; power stripes on met4, >= 1.2 um, within 10 um of both edges | TT precheck |
| `ua[i]` wired  <=>  `i < analog_pins` and pinout described | TT precheck |
| all 24 digital outputs connected (VGND or a tie cell) | TT analog spec |
| every project cell placed in the top layout equals its own verified layout | flow (no stale copies) |

The final authority is TT's own `gds` workflow on GitHub (precheck job with TT's pinned tools
and PDK). `tt-check` and `tt-precheck` exist so that it never surprises you.

## Known limits

* `make tt-precheck` uses this box's magic, KLayout and PDK version; TT's Action uses its own
  pinned versions (PDK sky130A `0536d02d875c8f67dd7cca3902ac457e62f20005` in tt-gds-action
  `ttsky26d`). A difference can only show up there.
* The top cell runs DRC in the flow but no LVS/PEX unless you give it a schematic; your core
  cell(s) carry the full LVS/PEX/post-layout verification.
* GitHub Pages (TT's viewer job) works on private repositories only with a paid GitHub plan;
  make the repository public before submitting.

## Cell libraries in KLayout (menu bar > Cell Library)

Start KLayout in editor mode (`klayout -e`). The **Cell Library** menu (next to Help) has:

| Item | Shortcut | Does |
|---|---|---|
| Library Manager... | Ctrl+Shift+L | libraries on the left, their cells on the right; create/delete libraries, create cells, open a cell's layout, place a cell, move a cell to another library |
| New Cell... | Ctrl+Shift+N | name + library -> creates `cells/<name>/` (same as `make new-cell`), an empty layout with top cell `<name>`, assigns it to the library and opens it |
| Place Cell... | Ctrl+Shift+P | pick library + cell -> instance in the current cell, at the centre of the view |
| New Library... | | creates `libs/<name>.lib` |
| Refresh Libraries | Ctrl+Shift+R | re-reads every cell layout; use after saving a cell (Ctrl+S) |

Every library is a normal KLayout library, so it also shows in KLayout's own **Libraries** panel
next to Basic and the sky130 PCells, where cells can be dragged into a layout.

Storage, all in git: `libs/<library>.lib` (one file per library) and `cells/<cell>/LIBRARY`
(the library of that cell; no file = the project's default library, named after the project).
Cells always stay in `cells/<cell>/`, so the flow, `make` and CI are unaffected.
