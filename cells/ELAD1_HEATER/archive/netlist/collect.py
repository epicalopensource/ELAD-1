import os, sys, numpy as np
stage = sys.argv[1]
V = float(os.environ.get("HIN_V", "1.8"))
cols = ["stage","corner","temp","ih_mA","rtot_ohm","p_mW","ih_half_mA","rtot_half_ohm",
        "ih_hen_half_mA","ileak_off_nA"]
rows = [",".join(cols)]
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
def load(fn):
    d = np.loadtxt(fn)
    return d[:, 0], np.abs(d[:, 1])
missing = []
for c in "tt ss ff sf fs".split():
  for t in (-20, 27, 85):
    tag = f"{c}_{t}"; S = f"results_dc/{stage}/sweeps/"
    if not all(os.path.exists(S + f"{k}_{tag}.txt") for k in ("on", "off", "hen")):
        missing.append(tag); continue
    x, y = load(S + f"on_{tag}.txt"); xo, yo = load(S + f"off_{tag}.txt"); xh, yh = load(S + f"hen_{tag}.txt")
    ih = np.interp(V, x, y); ihh = np.interp(V / 2, x, y)
    ihe = np.interp(0.9, xh, yh); il = np.interp(V, xo, yo)
    rows.append(",".join([stage, c, str(t), g(ih * 1e3), g(V / ih if ih else None), g(V * ih * 1e3),
        g(ihh * 1e3), g((V / 2) / ihh if ihh else None), g(ihe * 1e3), g(il * 1e9)]))
if missing:
    print("NO DATA for:", " ".join(missing)); sys.exit(1)
open(f"results_dc/{stage}/dc.csv", "w").write("\n".join(rows) + "\n")
print(stage, len(rows) - 1, "rows")
