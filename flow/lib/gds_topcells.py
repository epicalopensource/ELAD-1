# KLayout batch script — list top cells of a layout.
#   klayout -b -r gds_topcells.py -rd gds=<file>
# `gds` is injected as a global by `-rd`. Output lines are prefixed so callers can ignore
# any other text KLayout prints.
import pya

layout = pya.Layout()
layout.read(gds)  # noqa: F821  (defined by klayout -rd)
for cell in layout.top_cells():
    print("TOPCELL:" + cell.name)
