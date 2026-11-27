import os, sys, numpy as np
stage = sys.argv[1]
cols = ["stage","corner","temp","ion_uA","r_on_ohm","r_small_ohm","ion_clr_half_uA","ileak_off_nA"]
rows = [",".join(cols)]
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
def load(fn):
    d = np.loadtxt(fn)
    return d[:, 0], np.abs(d[:, 1])
missing = []
for c in "tt ss ff sf fs".split():
  for t in (-20, 27, 85):
    tag = f"{c}_{t}"; S = f"results_dc/{stage}/sweeps/"
    if not all(os.path.exists(S + f"{k}_{tag}.txt") for k in ("on", "off", "clr")):
        missing.append(tag); continue
    x, y = load(S + f"on_{tag}.txt"); xo, yo = load(S + f"off_{tag}.txt"); xc, yc = load(S + f"clr_{tag}.txt")
    ion = np.interp(0.9, x, y); isml = np.interp(0.05, x, y)
    rows.append(",".join([stage, c, str(t), g(ion * 1e6), g(0.9 / ion if ion else None), g(0.05 / isml if isml else None),
        g(np.interp(0.9, xc, yc) * 1e6), g(np.interp(1.8, xo, yo) * 1e9)]))
if missing:
    print("NO DATA for:", " ".join(missing)); sys.exit(1)
open(f"results_dc/{stage}/dc.csv", "w").write("\n".join(rows) + "\n")
print(stage, len(rows) - 1, "rows")
