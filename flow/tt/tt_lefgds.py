"""Library behind tt_export.py (no command line here, safe to import)."""
import os

from tt_common import TTError, find_layer, kdb, load_info, parse_def, power_pins, template_def_path, top_pins

OBS_LAYERS = ["li1", "met1", "met2", "met3", "met4"]


def _um(v_dbu, dbu):
    return f"{v_dbu * dbu:.3f}"


def write_gds(layout, out):
    opt = kdb.SaveLayoutOptions()
    opt.format = "GDS2"
    opt.write_context_info = False
    opt.gds2_write_timestamps = False
    opt.gds2_write_cell_properties = False
    opt.gds2_write_file_properties = False
    tmp = out + ".tmp"
    layout.write(tmp, opt)
    os.replace(tmp, out)


def build_lef(layout, top, info, tdef):
    dbu = layout.dbu
    pins = top_pins(layout, top)
    lines = [
        "VERSION 5.7 ;",
        "  NOWIREEXTENSIONATPIN ON ;",
        '  DIVIDERCHAR "/" ;',
        '  BUSBITCHARS "[]" ;',
        f"MACRO {top.name}",
        "  CLASS BLOCK ;",
        f"  FOREIGN {top.name} ;",
        "  ORIGIN 0.000 0.000 ;",
        f"  SIZE {tdef.width_nm / 1000:.3f} BY {tdef.height_nm / 1000:.3f} ;",
    ]
    order = list(tdef.pins) + power_pins(info)
    extra = sorted(set(pins) - set(order))
    if extra:
        raise TTError("top-level met4 pins not in the Tiny Tapeout template: " + ", ".join(extra)
                      + " (only template pins and VGND/VDPWR" + ("/VAPWR" if info.uses_vapwr else "")
                      + " may be pins)")
    pin_region = kdb.Region()
    for name in order:
        boxes = pins.get(name)
        if not boxes:
            continue  # missing pins are reported by tt_check; the LEF just omits them
        if name in tdef.pins:
            direction, use = tdef.pins[name].direction, "SIGNAL"
        else:
            direction, use = "INOUT", ("GROUND" if name == "VGND" else "POWER")
        lines += [f"  PIN {name}", f"    DIRECTION {direction} ;", f"    USE {use} ;", "    PORT",
                  "      LAYER met4 ;"]
        for b in sorted(boxes, key=lambda b: (b.left, b.bottom)):
            lines.append(f"        RECT {_um(b.left, dbu)} {_um(b.bottom, dbu)} "
                         f"{_um(b.right, dbu)} {_um(b.top, dbu)} ;")
            pin_region.insert(b)
        lines += ["    END", f"  END {name}"]

    obs = []
    for lay in OBS_LAYERS:
        li = find_layer(layout, lay)
        if li is None:
            continue
        region = kdb.Region(top.begin_shapes_rec(li)).merged()
        if lay == "met4":
            region -= pin_region
        rects = []
        for poly in region.each():
            for part in poly.decompose_trapezoids(kdb.Polygon.TD_htrapezoids):
                b = part.bbox()                 # Manhattan parts are boxes; others: safe bbox
                if b.width() > 0 and b.height() > 0:
                    rects.append(b)
        if rects:
            obs.append(f"      LAYER {lay} ;")
            for b in sorted(rects, key=lambda b: (b.bottom, b.left, b.top, b.right)):
                obs.append(f"        RECT {_um(b.left, dbu)} {_um(b.bottom, dbu)} "
                           f"{_um(b.right, dbu)} {_um(b.top, dbu)} ;")
    if obs:
        lines += ["  OBS"] + obs + ["  END"]
    lines += [f"END {top.name}", "END LIBRARY", ""]
    return "\n".join(lines)


def export(src, out_gds, out_lef):
    info = load_info()
    tdef = parse_def(template_def_path(info))
    layout = kdb.Layout()
    layout.read(src)
    top = layout.cell(info.top_module)
    if top is None:
        raise TTError(f"{src} has no cell named {info.top_module} (info.yaml top_module)")
    if abs(layout.dbu - 0.001) > 1e-12:
        raise TTError(f"{src}: database unit {layout.dbu} um, expected 0.001")
    # Drop cells that are not part of the top's tree (stray top cells would break TT's checks).
    keep = {top.cell_index()} | set(top.called_cells())
    for ci in [c.cell_index() for c in layout.each_cell() if c.cell_index() not in keep]:
        if layout.is_valid_cell_index(ci) and ci not in keep:
            layout.delete_cell(ci)
    os.makedirs(os.path.dirname(os.path.abspath(out_gds)) or ".", exist_ok=True)
    os.makedirs(os.path.dirname(os.path.abspath(out_lef)) or ".", exist_ok=True)
    write_gds(layout, out_gds)
    text = build_lef(layout, top, info, tdef)
    with open(out_lef + ".tmp", "w", encoding="utf-8") as f:
        f.write(text)
    os.replace(out_lef + ".tmp", out_lef)
    print(f"tt-export: {src} -> {out_gds}, {out_lef}")


