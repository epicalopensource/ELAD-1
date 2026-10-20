#!/usr/bin/env python3
"""Tiny Tapeout rule check for this repository (fast; KLayout only; runs locally and in CI).

    tt_check.py [--source-only]

Checks, each mapped to the TT rule it enforces:
  info      info.yaml filled in as TT's docs check requires; tt_um_ prefix; tiles 1x2/2x2;
            analog_pins 0..6; VAPWR needs an analog pin                    (TT docs + precheck)
  docs      docs/info.md no longer has the template's placeholder text     (TT docs Action)
  verilog   src/project.v declares module <top_module>; VAPWR port iff uses_vapwr
                                                                             (TT spec + precheck)
  source    cells/<top>/layout/<top>.gds exists (the verified layout)       (this flow)
  export    gds/<top>.gds and lef/<top>.lef are exactly what tt_export.py makes from it,
            i.e. what TT receives is what the flow verified                (this flow)
  layout    one top cell <top>; die = template; prBoundary rectangle; no met5; cell names
            without '#' or '/'                                              (TT precheck)
  pins      every template pin on met4.pin with the template rectangle; power pins on met4,
            >= 1.2 um wide, within 10 um of bottom and top                   (TT precheck)
  analog    ua[i] has metal attached  <=>  i < analog_pins and pinout ua[i] described
                                                                             (TT precheck)
  tieoff    unused outputs uo_out/uio_out/uio_oe connected (to VGND or a tie cell)
                                                                             (TT analog spec)
  hier      every project cell placed in the top layout (e.g. your core cell) is identical to
            its own verified cells/<name>/layout/<name>.gds — no outdated copies submitted
                                                                             (this flow)
--source-only skips 'export' (used before the first export).
The authoritative check is still TT's own precheck (their 'gds' GitHub Action, and
'make tt-precheck'); this one fails for the same reasons, earlier and in seconds.
"""
import filecmp
import os
import re
import sys
import tempfile

sys.path.insert(0, os.environ.get("KPY_DIR") or os.path.dirname(os.path.abspath(__file__)))
from tt_common import (FLOW_ROOT, FORBIDDEN, POWER_EDGE_NM, POWER_MIN_WIDTH_NM,  # noqa: E402
                       UNUSED_OUTPUTS, TTError, conf, die_box, find_layer, kdb, layer_index, load_info,
                       nm_box, parse_def, power_pins, run_main, template_def_path, top_pins)

REQUIRE_TIEOFF = conf("TT_REQUIRE_TIEOFF", "1") == "1"


class Report:
    def __init__(self):
        self.rows = []

    def add(self, check, ok, msg=""):
        self.rows.append((check, ok, msg))

    def fail(self, check, msg):
        self.add(check, False, msg)

    def done(self):
        bad = [r for r in self.rows if r[1] is False]
        warn = [r for r in self.rows if r[1] is None]
        for check, ok, msg in self.rows:
            tag = "PASS" if ok else ("WARN" if ok is None else "FAIL")
            print(f"  {tag:4}  {check:8}  {msg}")
        print(f"tt-check: {'FAIL' if bad else 'PASS'} ({len(bad)} failed, {len(warn)} warnings)")
        return 1 if bad else 0


def check_info(info, r):
    errs = []
    for key in ("title", "author", "description", "language"):
        if not getattr(info, key).strip():
            errs.append(f"project.{key} is empty")
    if not re.fullmatch(r"tt_um_[A-Za-z0-9_]+", info.top_module):
        errs.append(f"top_module {info.top_module!r} must start with tt_um_ (letters, digits, _)")
    if info.top_module == "tt_um_example":
        errs.append("top_module is still the template's tt_um_example (make tt-rename NEW=tt_um_...)")
    if info.tiles not in ("1x2", "2x2"):
        errs.append(f"tiles {info.tiles!r}: analog projects use 1x2 or 2x2")
    if not 1 <= info.analog_pins <= 6:
        errs.append(f"analog_pins {info.analog_pins}: must be 1..6 — with 0, TT's precheck treats "
                    "the project as DIGITAL (digital template, no ua pins) and rejects all 8 ua pins; "
                    "wire ua[0] (make tt-wire PIN=ua[0]) and describe it in the pinout")
    if info.uses_vapwr and info.analog_pins < 1:
        errs.append("uses_vapwr needs at least one analog pin")
    for f in info.source_files:
        if not os.path.isfile(os.path.join(FLOW_ROOT, "src", f)):
            errs.append(f"source file src/{f} listed in info.yaml does not exist")
    for i in range(6):
        if f"ua[{i}]" not in info.pinout:
            errs.append(f"pinout ua[{i}] missing (do not delete pins from info.yaml)")
    r.add("info", not errs, "; ".join(errs) or f"{info.top_module}, {info.tiles}, "
          f"{info.analog_pins} analog pin(s){', VAPWR' if info.uses_vapwr else ''}")


def check_docs(r):
    """Same rule as tt-support-tools/project_checks.py:check_info_md (TT's 'docs' Action)."""
    path = os.path.join(FLOW_ROOT, "docs", "info.md")
    if not os.path.isfile(path):
        r.fail("docs", "docs/info.md missing")
        return
    s = open(path, encoding="utf-8", errors="replace").read()
    errs = []
    if "# How it works\n\nExplain how your project works" in s:
        errs.append("'How it works' still has the template text")
    if "# How to test\n\nExplain how to use your project" in s:
        errs.append("'How to test' still has the template text")
    r.add("docs", not errs, "; ".join(errs) + " (edit docs/info.md)" if errs else
          "docs/info.md has its own How it works / How to test text")


def check_verilog(info, r):
    path = os.path.join(FLOW_ROOT, "src", "project.v")
    if not os.path.isfile(path):
        r.fail("verilog", "src/project.v missing")
        return
    s = open(path, encoding="utf-8", errors="replace").read()
    s = re.sub(r"/\*.*?\*/", "", re.sub(r"//.*", "", s), flags=re.S)
    errs = []
    m = re.search(r"\bmodule\s+(\w+)", s)
    if not m or m.group(1) != info.top_module:
        errs.append(f"module is {m.group(1) if m else 'missing'}, expected {info.top_module}")
    for p in ("VGND", "VDPWR"):
        if p not in s:
            errs.append(f"{p} port missing")
    if ("VAPWR" in s) != info.uses_vapwr:
        errs.append("VAPWR port must be present exactly when uses_vapwr is true "
                    "(uncomment/comment it in src/project.v)")
    r.add("verilog", not errs, "; ".join(errs) or "module name and power ports match info.yaml")


def check_layout(info, tdef, gds, r):
    layout = kdb.Layout()
    layout.read(gds)
    tops = [c.name for c in layout.top_cells()]
    errs = []
    if tops != [info.top_module]:
        errs.append(f"top cells {tops}, expected exactly [{info.top_module}]")
    top = layout.cell(info.top_module)
    if top is None:
        r.fail("layout", "; ".join(errs))
        return None, None
    dbu = layout.dbu
    die = die_box(tdef, dbu)
    if top.bbox() != die:
        errs.append(f"bounding box {top.dbbox()} != template die (0,0;{tdef.width_nm/1000},"
                    f"{tdef.height_nm/1000}) — shapes outside, or prBoundary missing")
    bi = find_layer(layout, "prBoundary")
    if bi is None or not any(s.box == die for s in top.shapes(bi).each() if s.is_box()):
        errs.append("no top-level prBoundary (235/4) rectangle covering the die")
    for name in FORBIDDEN:
        li = find_layer(layout, name)
        if li is not None and not kdb.Region(top.begin_shapes_rec(li)).is_empty():
            errs.append(f"{name} used (metal 5 is reserved for Tiny Tapeout's power grid)")
    bad_names = [c.name for c in layout.each_cell() if "#" in c.name or "/" in c.name]
    if bad_names:
        errs.append(f"cell names with '#' or '/': {bad_names[:5]}")
    r.add("layout", not errs, "; ".join(errs) or f"top {info.top_module}, die "
          f"{tdef.width_nm/1000} x {tdef.height_nm/1000} um, prBoundary, no met5")
    return layout, top


def check_pins(info, tdef, layout, top, r):
    dbu = layout.dbu
    pins = top_pins(layout, top)
    errs = []
    for name, p in tdef.pins.items():
        want = nm_box(p.rect_nm, dbu)
        got = pins.get(name, [])
        if not got:
            errs.append(f"{name} missing (met4.pin + met4.label at the template position)")
        elif len(got) != 1 or got[0] != want:
            errs.append(f"{name} shape differs from template (do not move/resize template pins)")
    h = round(tdef.height_nm * 0.001 / dbu)
    for name in power_pins(info):
        got = pins.get(name, [])
        if not got:
            errs.append(f"power pin {name} missing (vertical met4 stripe with met4.pin + label)")
        for b in got:
            if b.width() * dbu * 1000 < POWER_MIN_WIDTH_NM:
                errs.append(f"{name} stripe {b.width()*dbu:.3f} um wide (< 1.2 um)")
            if b.bottom * dbu * 1000 > POWER_EDGE_NM or (h - b.top) * dbu * 1000 > POWER_EDGE_NM:
                errs.append(f"{name} stripe must start within 10 um of the bottom and reach "
                            "within 10 um of the top")
    if not info.uses_vapwr and pins.get("VAPWR"):
        errs.append("VAPWR pin present but uses_vapwr is false")
    allowed = set(tdef.pins) | set(power_pins(info))
    extra = sorted(set(pins) - allowed)
    if extra:
        errs.append(f"unexpected top-level met4 pins: {extra}")
    r.add("pins", not errs, "; ".join(errs) or f"{len(tdef.pins)} template pins exact, "
          + ", ".join(power_pins(info)) + " stripes OK")


def _connectivity(layout, top):
    l2n = kdb.LayoutToNetlist(kdb.RecursiveShapeIterator(layout, top, []))
    names = ["li1", "mcon", "met1", "via", "met2", "via2", "met3", "via3", "met4"]
    regs = {}
    for n in names:
        li = find_layer(layout, n)
        regs[n] = l2n.make_layer(li if li is not None else layer_index(layout, n), n)
    for n in names:
        l2n.connect(regs[n])
    for a, v, b in (("li1", "mcon", "met1"), ("met1", "via", "met2"), ("met2", "via2", "met3"),
                    ("met3", "via3", "met4")):
        l2n.connect(regs[a], regs[v])
        l2n.connect(regs[v], regs[b])
    l2n.extract_netlist()
    return l2n, regs


def check_analog_and_tieoff(info, tdef, layout, top, r):
    dbu = layout.dbu
    l2n, regs = _connectivity(layout, top)

    def net_at(box):
        return l2n.probe_net(regs["met4"], box.center())

    def net_reach(net):
        out = {}
        for n in ("li1", "met1", "met2", "met3", "met4"):
            out[n] = l2n.shapes_of_net(net, regs[n], True) if net is not None else kdb.Region()
        return out

    # analog pins: TT precheck logic (metal in a 0.1..0.5 um ring around the pin, or via3 on it)
    errs = []
    m4 = kdb.Region(top.begin_shapes_rec(layer_index(layout, "met4"))).merged()
    v3 = kdb.Region(top.begin_shapes_rec(layer_index(layout, "via3")))
    for i in range(8):
        name = f"ua[{i}]"
        if name not in tdef.pins:
            continue
        pin = nm_box(tdef.pins[name].rect_nm, dbu)
        ring = kdb.Region(pin.enlarged(round(0.5 / dbu))) - kdb.Region(pin.enlarged(round(0.1 / dbu)))
        connected = not (m4 & ring).is_empty() or not (v3 & kdb.Region(pin)).is_empty()
        expected = i < info.analog_pins
        described = bool(str(info.pinout.get(name, "") or "").strip())
        if info.analog_pins == 0:
            continue                      # TT runs this check only for analog projects
        if connected and not expected:
            errs.append(f"{name} has metal attached but analog_pins = {info.analog_pins}")
        elif connected and not described:
            errs.append(f"{name} has metal attached but its pinout description is empty")
        elif not connected and expected:
            errs.append(f"{name} not wired but analog_pins = {info.analog_pins}")
        elif not connected and described:
            errs.append(f"{name} described in pinout but not wired")
    r.add("analog", not errs, "; ".join(errs) or
          (f"ua[0..{info.analog_pins-1}] wired and described, others free"
           if info.analog_pins else "no analog pins"))

    # tie-offs: TT analog spec — connect unused uo_out, uio_out and uio_oe to ground
    pins = top_pins(layout, top)
    gnd_boxes = pins.get("VGND", [])
    gnd_net = net_at(gnd_boxes[0]) if gnd_boxes else None
    floating = []
    for name in UNUSED_OUTPUTS:
        boxes = pins.get(name)
        if not boxes:
            continue
        net = net_at(boxes[0])
        reach = net_reach(net)
        to_gnd = gnd_net is not None and net is not None and net.cluster_id == gnd_net.cluster_id
        to_cell = not reach["li1"].is_empty()        # e.g. a tie cell (sky130_fd_sc_hd__conb_1)
        if not (to_gnd or to_cell):
            floating.append(name)
    if floating:
        msg = (f"{len(floating)} output pin(s) not connected: {', '.join(floating[:6])}"
               f"{' ...' if len(floating) > 6 else ''} — TT: connect unused uo_out, uio_out, "
               "uio_oe to VGND (metal to the VGND stripe, or a conb tie cell)")
        r.add("tieoff", False if REQUIRE_TIEOFF else None, msg)
    else:
        r.add("tieoff", True, "all 24 digital output pins tied")


def _same_layout(a, b):
    """Geometry-level comparison (independent of the KLayout version that wrote the files)."""
    la, lb = kdb.Layout(), kdb.Layout()
    la.read(a)
    lb.read(b)
    return _same_layouts(la, lb)


def check_hierarchy(info, layout, top, r):
    cells_dir = os.path.join(FLOW_ROOT, "cells")
    project = {d for d in os.listdir(cells_dir) if not d.startswith("_") and d != info.top_module
               and os.path.isfile(os.path.join(cells_dir, d, "layout", f"{d}.gds"))}
    used = {layout.cell(ci).name: ci for ci in top.called_cells()}
    placed = sorted(n for n in used if n in project)
    stale = []
    for name in placed:
        a = kdb.Layout()
        a.dbu = layout.dbu
        a.create_cell(name).copy_tree(layout.cell(used[name]))
        b = kdb.Layout()
        b.read(os.path.join(cells_dir, name, "layout", f"{name}.gds"))
        bt = b.cell(name)
        if bt is None:
            stale.append(f"{name} (its own GDS has no top cell {name})")
            continue
        for ci in [c.cell_index() for c in b.top_cells() if c.name != name]:
            b.delete_cell_rec(ci)
        if not _same_layouts(a, b):
            stale.append(name)
    if stale:
        r.fail("hier", "outdated copy in the top layout: " + ", ".join(stale) +
               " — re-place the current cell in KLayout (or reopen the top layout and save)")
    else:
        r.add("hier", True, ("placed project cells match their verified layouts: " + ", ".join(placed))
              if placed else "no project cells placed in the top layout yet")


def _strip_empty_layers(layout):
    for li in list(layout.layer_indexes()):
        if all(c.shapes(li).is_empty() for c in layout.each_cell()):
            layout.delete_layer(li)


def _same_layouts(la, lb):
    for lay in (la, lb):
        _strip_empty_layers(lay)
    flags = (kdb.LayoutDiff.Silent | kdb.LayoutDiff.SmartCellMapping | kdb.LayoutDiff.BoxesAsPolygons
             | kdb.LayoutDiff.PathsAsPolygons | kdb.LayoutDiff.NoProperties)
    return kdb.LayoutDiff().compare(la, lb, flags)


def main(args):
    source_only = "--source-only" in args
    r = Report()
    try:
        info = load_info()
        tdef = parse_def(template_def_path(info))
    except TTError as e:
        print(f"tt-check: ERROR: {e}", file=sys.stderr)
        return 1
    check_info(info, r)
    check_docs(r)
    check_verilog(info, r)
    top = info.top_module
    src = os.path.join(FLOW_ROOT, "cells", top, "layout", f"{top}.gds")
    if not os.path.isfile(src):
        r.fail("source", f"cells/{top}/layout/{top}.gds missing (make tt-init)")
        return r.done()
    r.add("source", True, f"cells/{top}/layout/{top}.gds")

    if not source_only:
        gds = os.path.join(FLOW_ROOT, "gds", f"{top}.gds")
        lef = os.path.join(FLOW_ROOT, "lef", f"{top}.lef")
        if not (os.path.isfile(gds) and os.path.isfile(lef)):
            r.fail("export", f"gds/{top}.gds or lef/{top}.lef missing (make tt)")
        else:
            from tt_lefgds import export
            with tempfile.TemporaryDirectory() as d:
                eg, el = os.path.join(d, "a.gds"), os.path.join(d, "a.lef")
                import contextlib
                import io
                with contextlib.redirect_stdout(io.StringIO()):
                    export(src, eg, el)
                same_lef = filecmp.cmp(el, lef, shallow=False)
                same_gds = _same_layout(eg, gds)
            ctx = b"$$$CONTEXT_INFO$$$" in open(gds, "rb").read()
            errs = []
            if not same_gds:
                errs.append(f"gds/{top}.gds differs from cells/{top}/layout/{top}.gds")
            if not same_lef:
                errs.append(f"lef/{top}.lef is out of date")
            if ctx:
                errs.append(f"gds/{top}.gds contains KLayout context info (a 2nd top cell for TT)")
            r.add("export", not errs, "; ".join(errs) + " — run make tt, then commit" if errs else
                  "gds/ and lef/ are exactly the verified layout")
    layout, topc = check_layout(info, tdef, src, r)
    if layout is not None:
        check_pins(info, tdef, layout, topc, r)
        check_analog_and_tieoff(info, tdef, layout, topc, r)
        check_hierarchy(info, layout, topc, r)
    return r.done()


run_main(__name__, main)
