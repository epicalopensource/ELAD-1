#!/usr/bin/env python3
"""Export the verified top cell to the files Tiny Tapeout reads, deterministically.

    tt_export.py <src.gds> <out.gds> <out.lef>

GDS  cells/<top>/layout/<top>.gds  ->  gds/<top>.gds
     * hierarchy kept (TT: "leave it hierarchical"); nothing flattened
     * KLayout's PCell/library context cell ($$$CONTEXT_INFO$$$) is NOT written: TT's boundary
       check reads the GDS with gdstk, where that cell would be a second top-level cell
       ("GDS top level not unique"). PCells are written as their static geometry.
     * no timestamps, so the same input always gives byte-identical output (CI compares bytes)
LEF  pin-only abstract, the equivalent of magic 'lef write -pinonly':
     * MACRO <top>, ORIGIN 0 0, SIZE = template die area
     * one PIN per top-level met4.pin shape named by its label; DIRECTION from the template DEF,
       VGND -> USE GROUND, VDPWR/VAPWR -> USE POWER
     * OBS = all other li1..met4 geometry (incl. the rest of each pin's net), pins cut out
"""
import os
import sys

sys.path.insert(0, os.environ.get("KPY_DIR") or os.path.dirname(os.path.abspath(__file__)))
from tt_common import TTError, run_main  # noqa: E402
from tt_lefgds import export  # noqa: E402


def main(args):
    if len(args) != 3:
        print(__doc__, file=sys.stderr)
        return 2
    try:
        export(*args)
        return 0
    except TTError as e:
        print(f"tt-export: ERROR: {e}", file=sys.stderr)
        return 1


run_main(__name__, main)
