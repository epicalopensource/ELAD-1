"""Shared Tiny Tapeout helpers for the analog flow: info.yaml, DEF templates, layers.

Everything here mirrors what Tiny Tapeout's own precheck (tt-support-tools/precheck) reads,
so the flow's checks fail for the same reasons TT's would, only earlier and locally.

Runs under plain python3 (with the 'klayout' module) or inside KLayout (pya).
"""
from __future__ import annotations

import os
import re
import sys
from dataclasses import dataclass, field

try:
    import pya as kdb                         # inside KLayout (klayout -b -r ...)
except ImportError:                           # plain python3 with 'pip install klayout'
    import klayout.db as kdb                  # noqa: F401

FLOW_ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", ".."))
DEF_DIR = os.path.join(FLOW_ROOT, "flow", "tt", "def")

# sky130A layer numbers (from the PDK's sky130A.lyp, as used by TT precheck).
L = {
    "prBoundary": (235, 4),
    "li1": (67, 20), "li1.pin": (67, 16), "li1.label": (67, 5), "mcon": (67, 44),
    "met1": (68, 20), "met1.pin": (68, 16), "met1.label": (68, 5), "via": (68, 44),
    "met2": (69, 20), "met2.pin": (69, 16), "met2.label": (69, 5), "via2": (69, 44),
    "met3": (70, 20), "met3.pin": (70, 16), "met3.label": (70, 5), "via3": (70, 44),
    "met4": (71, 20), "met4.pin": (71, 16), "met4.label": (71, 5),
    "met5": (72, 20), "met5.pin": (72, 16), "met5.label": (72, 5),
}
FORBIDDEN = ["met5", "met5.pin", "met5.label"]
POWER_LAYER = "met4"
POWER_MIN_WIDTH_NM = 1200          # 1.2 um
POWER_EDGE_NM = 10000              # stripes within 10 um of bottom and top
VALID_TILES = ("1x2", "2x2")       # analog projects (template comment: "Valid values ... 1x2, 2x2")
UNUSED_OUTPUTS = [f"uo_out[{i}]" for i in range(8)] + [f"uio_out[{i}]" for i in range(8)] \
    + [f"uio_oe[{i}]" for i in range(8)]


class TTError(Exception):
    pass


def conf(key: str, default: str = "") -> str:
    """Setting from the environment (make exports it) or else from flow.conf ('KEY ?= value';
    the last definition wins, as in make)."""
    if key in os.environ:
        return os.environ[key]
    value = default
    rx = re.compile(r"^\s*%s\s*\?=\s*(.*\S)\s*$" % re.escape(key))
    try:
        with open(os.path.join(FLOW_ROOT, "flow.conf"), encoding="utf-8", errors="replace") as f:
            for line in f:
                m = rx.match(line)
                if m:
                    value = m.group(1)
    except OSError:
        pass
    return value


def finish(rc: int):
    """Exit with rc, both under python3 and under klayout -b -r (where SystemExit is unreliable)."""
    sys.stdout.flush()
    sys.stderr.flush()
    if "KPY_ARGV" in os.environ:
        os._exit(rc)
    sys.exit(rc)


def run_main(name: str, main):
    if name == "__main__" or "KPY_ARGV" in os.environ:
        finish(main(argv()))


def argv():
    """Arguments: sys.argv under python3, $KPY_ARGV (newline separated) under klayout -b -r."""
    if "KPY_ARGV" in os.environ:
        return [a for a in os.environ["KPY_ARGV"].split("\n") if a != ""]
    return sys.argv[1:]


# ---------------------------------------------------------------------------------- info.yaml
@dataclass
class Info:
    path: str
    title: str
    author: str
    description: str
    language: str
    top_module: str
    tiles: str
    analog_pins: int
    uses_vapwr: bool
    source_files: list
    pinout: dict
    yaml_version: object
    raw: dict = field(repr=False, default_factory=dict)


def load_info(root: str = FLOW_ROOT) -> Info:
    try:
        import yaml
    except ImportError as e:
        raise TTError("python3 module 'yaml' missing (pip install pyyaml)") from e
    path = os.path.join(root, "info.yaml")
    if not os.path.isfile(path):
        raise TTError(f"{path} not found: this repository must be created from the Tiny Tapeout "
                      "analog template (TinyTapeout/ttsky-analog-template)")
    with open(path, encoding="utf-8", errors="replace") as f:
        data = yaml.safe_load(f) or {}
    p = data.get("project") or {}
    return Info(
        path=path,
        title=str(p.get("title", "") or ""),
        author=str(p.get("author", "") or ""),
        description=str(p.get("description", "") or ""),
        language=str(p.get("language", "") or ""),
        top_module=str(p.get("top_module", "") or ""),
        tiles=str(p.get("tiles", "") or ""),
        analog_pins=int(p.get("analog_pins", 0) or 0),
        # "uses_3v3" is the legacy name TT still accepts.
        uses_vapwr=bool(p.get("uses_vapwr", p.get("uses_3v3", False))),
        source_files=list(p.get("source_files") or []),
        pinout=dict(data.get("pinout") or {}),
        yaml_version=data.get("yaml_version"),
        raw=data,
    )


def template_def_path(info: Info, pdk: str = "sky130A") -> str:
    name = f"tt_analog_{info.tiles}{'_3v3' if info.uses_vapwr else ''}.def"
    path = os.path.join(DEF_DIR, pdk, "analog", name)
    if not os.path.isfile(path):
        raise TTError(f"no Tiny Tapeout template {name} (tiles={info.tiles!r}, "
                      f"uses_vapwr={info.uses_vapwr}) in {os.path.dirname(path)}")
    return path


def power_pins(info: Info) -> list:
    return ["VGND", "VDPWR"] + (["VAPWR"] if info.uses_vapwr else [])


# ------------------------------------------------------------------------------------- DEF
@dataclass
class DefPin:
    name: str
    direction: str
    use: str
    layer: str
    rect_nm: tuple          # (lx, by, rx, ty) absolute, nm


@dataclass
class DefTemplate:
    path: str
    design: str
    width_nm: int
    height_nm: int
    pins: dict              # name -> DefPin (ordered as in the file)


def _nm(value: str, dbu_per_um: int) -> int:
    v = int(value)
    if (v * 1000) % dbu_per_um:
        raise TTError(f"DEF value {value} not on a 1 nm grid")
    return v * 1000 // dbu_per_um


def parse_def(path: str) -> DefTemplate:
    """Same subset and rules as tt-support-tools/precheck/pin_check.py:parse_def."""
    units_re = re.compile(r"UNITS DISTANCE MICRONS (\S+) ;")
    die_re = re.compile(r"DIEAREA \( (\S+) (\S+) \) \( (\S+) (\S+) \) ;")
    design_re = re.compile(r"DESIGN (\S+) ;")
    pin_re = re.compile(r" *- (\S+) \+ NET (\S+) \+ DIRECTION (\S+) \+ USE (\S+)")
    layer_re = re.compile(r" *\+ LAYER (\S+) \( (\S+) (\S+) \) \( (\S+) (\S+) \)")
    placed_re = re.compile(r" *\+ PLACED \( (\S+) (\S+) \) (\S+) ;")
    with open(path, encoding="utf-8", errors="replace") as f:
        lines = f.read().splitlines()
    dbu, design, w, h, pins = 0, "", 0, 0, {}
    i = 0
    while i < len(lines):
        line = lines[i]
        if line.startswith("UNITS "):
            dbu = int(units_re.match(line).group(1))
        elif line.startswith("DESIGN "):
            design = design_re.match(line).group(1)
        elif line.startswith("DIEAREA "):
            lx, by, rx, ty = (_nm(v, dbu) for v in die_re.match(line).groups())
            if (lx, by) != (0, 0):
                raise TTError("template DEF die origin is not (0, 0)")
            w, h = rx, ty
        elif re.match(r"PINS \d+ ;", line):
            count = int(line.split()[1])
            for _ in range(count):
                name, net, direction, use = pin_re.match(lines[i + 1]).groups()
                if lines[i + 2].strip() != "+ PORT":
                    raise TTError(f"unexpected DEF syntax near pin {name}")
                layer, lx, by, rx, ty = layer_re.match(lines[i + 3]).groups()
                ox, oy, _orient = placed_re.match(lines[i + 4]).groups()
                lx, by, rx, ty, ox, oy = (_nm(v, dbu) for v in (lx, by, rx, ty, ox, oy))
                pins[name] = DefPin(name, direction, use, layer, (ox + lx, oy + by, ox + rx, oy + ty))
                i += 4
            break
        i += 1
    if not (dbu and w and h and pins):
        raise TTError(f"could not parse template DEF {path}")
    return DefTemplate(path, design, w, h, pins)


# ------------------------------------------------------------------------------------- GDS
def layer_index(layout, name: str) -> int:
    ln, dt = L[name]
    return layout.layer(ln, dt)


def find_layer(layout, name: str):
    ln, dt = L[name]
    return layout.find_layer(ln, dt)


def nm_box(rect_nm, dbu_um: float):
    """(lx, by, rx, ty) in nm -> kdb.Box in database units."""
    f = 0.001 / dbu_um
    lx, by, rx, ty = rect_nm
    return kdb.Box(round(lx * f), round(by * f), round(rx * f), round(ty * f))


def die_box(t: DefTemplate, dbu_um: float):
    return nm_box((0, 0, t.width_nm, t.height_nm), dbu_um)


def top_pins(layout, cell, pin_layer: str = "met4.pin", label_layer: str = "met4.label"):
    """{pin name: [kdb.Box in DBU]} for top-level pin shapes named by a text label inside them.
    Only shapes directly in the top cell count (TT precheck looks at top-level polygons only)."""
    pi, li = find_layer(layout, pin_layer), find_layer(layout, label_layer)
    if pi is None:
        return {}
    texts = []
    for lay in (li, pi):                       # labels on .label (preferred) or on .pin itself
        if lay is None:
            continue
        for s in cell.shapes(lay).each(kdb.Shapes.STexts):
            t = s.text
            texts.append((t.string, kdb.Point(t.x, t.y)))
    region = kdb.Region(cell.shapes(pi)).merged()
    out = {}
    for poly in region.each():
        names = {t for t, p in texts if poly.inside(p)}
        for n in names:
            out.setdefault(n, []).append(poly.bbox())
    return out
