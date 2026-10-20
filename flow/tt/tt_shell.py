#!/usr/bin/env python3
"""Create the Tiny Tapeout top-level layout shell, or rename its top cell.

    tt_shell.py init   <out.gds> [VDPWR:x_um VGND:x_um ...]   (refuses to overwrite)
    tt_shell.py rename <gds> <old_top> <new_top>
    tt_shell.py stub   <gds> <ua[i]> [length_um]               (met4 lead from an analog pin)

The shell is generated from TT's own template DEF (flow/tt/def/...), chosen from info.yaml
(tiles, uses_vapwr), so its pins are exactly where TT's precheck expects them:
  * prBoundary (235/4) rectangle = die area           (precheck: Boundary check)
  * every template pin as met4 drawing + met4.pin + met4.label text, exact DEF rectangle
                                                      (precheck: Pin check; pin/label over drawing)
  * power stripes VDPWR, VGND (+ VAPWR) on met4, 5 um from bottom and top edges, width
    TT_STRIPE_W (default 2 um >= 1.2 um), drawing + pin + label (precheck: Power pin check)
  * tie-offs (TT_TIEOFF=1, default): every uo_out/uio_out/uio_oe pin extended down on met4 to
    a via3 on a met3 bus that joins the VGND stripe (TT analog spec: "connect unused uo_out,
    uio_out and uio_oe to GND"). Delete a pin's stub if you drive that output yourself.
The analog pins stay unconnected until you wire them (precheck: Analog pin check compares
this with info.yaml).
"""
import os
import sys

sys.path.insert(0, os.environ.get("KPY_DIR") or os.path.dirname(os.path.abspath(__file__)))
from tt_common import (TTError, conf, die_box, kdb, layer_index, load_info, nm_box,  # noqa: E402
                       parse_def, power_pins, run_main, template_def_path)

STRIPE_MARGIN_NM = 5000

# Tie-off geometry (nm). Rules respected with margin (sky130): via3 0.2 x 0.2; met4 encloses
# via3 by 0.15 (>= 0.065), met3 by 0.2 (>= 0.09); met3/met4 width >= 0.3; all on the 5 nm grid.
TIE_BUS_Y = (221750, 222350)       # met3 bus (0.6 um tall), below the top pin row (224.76)
TIE_VIA_Y = (221950, 222150)
TIE_PAD = 250                      # met4 landing pad half-size (0.5 x 0.5 um)
TIE_STUB_BOTTOM = 221650
VGND_TOP_WITH_TIE = 222650


def _box(cell, layout, lay, rect, dbu):
    cell.shapes(layer_index(layout, lay)).insert(nm_box(rect, dbu))


def _tieoffs(top, layout, tdef, vgnd_rect, dbu):
    outs = [p for n, p in tdef.pins.items() if n.startswith(("uo_out[", "uio_out[", "uio_oe["))]
    if not outs:
        return 0
    max_rx = max(p.rect_nm[2] for p in outs)
    for p in outs:
        lx, by, rx, _ = p.rect_nm
        cx = (lx + rx) // 2
        _box(top, layout, "met4", (lx, TIE_STUB_BOTTOM, rx, by), dbu)
        _box(top, layout, "met4", (cx - TIE_PAD, TIE_BUS_Y[0] + 50, cx + TIE_PAD, TIE_BUS_Y[1] - 50), dbu)
        _box(top, layout, "via3", (cx - 100, TIE_VIA_Y[0], cx + 100, TIE_VIA_Y[1]), dbu)
    vlx, _, vrx, _ = vgnd_rect
    _box(top, layout, "met3", (vlx + 200, TIE_BUS_Y[0], max_rx + 300, TIE_BUS_Y[1]), dbu)
    for x in (vlx + 500, vrx - 700):          # two via3 from the bus up into the VGND stripe
        _box(top, layout, "via3", (x, TIE_VIA_Y[0], x + 200, TIE_VIA_Y[1]), dbu)
    return len(outs)


def _pin(cell, layout, name, box, text_size):
    for lay in ("met4", "met4.pin"):
        cell.shapes(layer_index(layout, lay)).insert(box)
    c = box.center()
    t = kdb.Text(name, kdb.Trans(c.x, c.y))
    t.size = text_size
    cell.shapes(layer_index(layout, "met4.label")).insert(t)


def init(out, stripe_args):
    if os.path.exists(out):
        raise TTError(f"{out} exists; not overwriting your layout (delete it first to regenerate)")
    info = load_info()
    tdef = parse_def(template_def_path(info))
    top_name = info.top_module

    layout = kdb.Layout()
    layout.dbu = 0.001
    top = layout.create_cell(top_name)
    dbu = layout.dbu

    top.shapes(layer_index(layout, "prBoundary")).insert(die_box(tdef, dbu))
    for pin in tdef.pins.values():
        if pin.layer != "met4":
            raise TTError(f"template pin {pin.name} on unexpected layer {pin.layer}")
        _pin(top, layout, pin.name, nm_box(pin.rect_nm, dbu), 300)

    width_nm = int(round(float(conf("TT_STRIPE_W", "2")) * 1000))
    if width_nm < 1200:
        raise TTError("TT_STRIPE_W must be >= 1.2 um (Tiny Tapeout power pin rule)")
    xs = {}
    default_x = 1.0
    for name in power_pins(info):
        xs[name] = default_x
        default_x += 3.0
    for arg in stripe_args:
        name, _, x = arg.partition(":")
        if name not in xs:
            raise TTError(f"unknown power pin {name!r}; expected one of {list(xs)}")
        xs[name] = float(x)
    tieoff = conf("TT_TIEOFF", "1") == "1"
    rects = {}
    for name, x_um in xs.items():
        lx = int(round(x_um * 1000))
        ty = tdef.height_nm - STRIPE_MARGIN_NM
        if name == "VGND" and tieoff:
            ty = VGND_TOP_WITH_TIE
        rect = (lx, STRIPE_MARGIN_NM, lx + width_nm, ty)
        if rect[0] < 0 or rect[2] > tdef.width_nm:
            raise TTError(f"{name} stripe at x={x_um} um is outside the die")
        rects[name] = rect
        _pin(top, layout, name, nm_box(rect, dbu), 1000)
    outs = [p.rect_nm[0] for n, p in tdef.pins.items() if n.startswith(("uo_out[", "uio_out[", "uio_oe["))]
    for name, rect in rects.items():
        if rect[2] + 1000 > min(outs) and rect[0] < max(outs) and (name == "VGND" or tieoff):
            raise TTError(f"{name} stripe at x={rect[0]/1000} um runs under the output pins; "
                          "place the stripes left of x=" + f"{min(outs)/1000 - 1:.2f} um")
    n_tied = _tieoffs(top, layout, tdef, rects["VGND"], dbu) if tieoff else 0

    os.makedirs(os.path.dirname(os.path.abspath(out)), exist_ok=True)
    opt = kdb.SaveLayoutOptions()
    opt.format = "GDS2"
    layout.write(out, opt)
    print(f"tt-shell: wrote {out}: top cell {top_name}, die {tdef.width_nm/1000} x "
          f"{tdef.height_nm/1000} um ({info.tiles}{', VAPWR' if info.uses_vapwr else ''}), "
          f"{len(tdef.pins)} template pins, stripes " +
          ", ".join(f"{n}@x={x}um" for n, x in xs.items()) +
          (f", {n_tied} outputs tied to VGND" if tieoff else ", outputs NOT tied (TT_TIEOFF=0)"))


def rename(gds, old, new):
    layout = kdb.Layout()
    layout.read(gds)
    cell = layout.cell(old)
    if cell is None:
        raise TTError(f"{gds} has no cell named {old}")
    if layout.cell(new) is not None:
        raise TTError(f"{gds} already has a cell named {new}")
    cell.name = new
    opt = kdb.SaveLayoutOptions()
    opt.format = "GDS2"
    layout.write(gds, opt)
    print(f"tt-shell: renamed top cell {old} -> {new} in {gds}")


def stub(gds, pin_name, length_um="10"):
    """Draw a met4 lead from an analog pin into the die: it marks the pin as used (TT's analog pin
    check), and is where you connect your circuit."""
    info = load_info()
    tdef = parse_def(template_def_path(info))
    if not pin_name.startswith("ua[") or pin_name not in tdef.pins:
        raise TTError(f"{pin_name}: give an analog pin, e.g. ua[0]")
    layout = kdb.Layout()
    layout.read(gds)
    top = layout.cell(info.top_module)
    if top is None:
        raise TTError(f"{gds} has no cell {info.top_module}")
    lx, by, rx, ty = tdef.pins[pin_name].rect_nm
    length = int(round(float(length_um) * 1000))
    top.shapes(layer_index(layout, "met4")).insert(nm_box((lx, ty, rx, ty + length), layout.dbu))
    opt = kdb.SaveLayoutOptions()
    opt.format = "GDS2"
    layout.write(gds, opt)
    print(f"tt-shell: met4 lead {lx/1000:.2f}..{rx/1000:.2f} um wide, {length/1000} um up from "
          f"{pin_name} in {gds}")


def main(args):
    try:
        if len(args) >= 2 and args[0] == "init":
            init(args[1], args[2:])
        elif len(args) == 4 and args[0] == "rename":
            rename(args[1], args[2], args[3])
        elif len(args) in (3, 4) and args[0] == "stub":
            stub(*args[1:])
        else:
            print(__doc__, file=sys.stderr)
            return 2
        return 0
    except TTError as e:
        print(f"tt-shell: ERROR: {e}", file=sys.stderr)
        return 1


run_main(__name__, main)
