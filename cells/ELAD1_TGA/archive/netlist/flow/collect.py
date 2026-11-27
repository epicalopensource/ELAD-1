import os, sys, numpy as np
stage = sys.argv[1]
VS = [0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3, 1.5, 1.7]
cols = ["stage", "corner", "temp"] + [f"ron_{v:.1f}V_ohm".replace(".", "p") for v in VS] + \
       ["ron_max_ohm", "vc_at_ron_max_V", "ron_min_ohm", "leak_nA", "bw_MHz", "off_iso_100MHz_dB"]
rows = [",".join(cols)]
def rd(fn): return np.atleast_2d(np.loadtxt(fn))
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
missing = []
for c in "tt ss ff sf fs".split():
  for t in (-20, 27, 85):
    S = f"results/{stage}/sweeps/"; tag = f"{c}_{t}"
    fs = [S + f"{n}_{tag}.txt" for n in ("ron", "leak1", "leak2", "acon", "acoff")]
    if not all(os.path.exists(f) for f in fs): missing.append(tag); continue
    d = rd(fs[0]); vc = d[:, 0]; ron = 0.01 / np.maximum(np.abs(d[:, 1]), 1e-30)
    rv = [np.interp(v, vc, ron) for v in VS]; k = int(np.argmax(ron))
    leak = max(abs(rd(fs[1])[0, 1]), abs(rd(fs[2])[0, 1])) * 1e9
    a = rd(fs[3]); f, gv = a[:, 0], a[:, 1]; g0 = gv[0]
    below = np.where(gv < g0 - 3)[0]
    if len(below) and below[0] > 0:
      j = below[0]; bw = 10 ** np.interp(g0 - 3, [gv[j], gv[j-1]], [np.log10(f[j]), np.log10(f[j-1])]) / 1e6
    else: bw = float("nan")
    b = rd(fs[4]); iso = -np.interp(np.log10(1e8), np.log10(b[:, 0]), b[:, 1])
    rows.append(",".join([stage, c, str(t)] + [g(x) for x in rv] + [g(ron[k]), g(vc[k]), g(ron.min()), g(leak), g(bw), g(iso)]))
if missing:
    print("NO DATA for:", " ".join(missing), "- see results/%s/log_dc_<tag>.txt and log_ac_<tag>.txt" % stage); sys.exit(1)
open(f"results/{stage}/dc.csv", "w").write("\n".join(rows) + "\n")
print(stage, len(rows) - 1, "rows")
