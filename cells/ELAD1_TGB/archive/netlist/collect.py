import os, re, sys, numpy as np
stage = sys.argv[1]
VS = ["0p1","0p3","0p5","0p7","0p9","1p1","1p3","1p5","1p7"]
cols = ["stage","corner","temp"] + [f"ron_{v}V_ohm" for v in VS] + ["ron_max_ohm","vc_at_ron_max_V","ron_min_ohm","leak_nA","bw_MHz","off_iso_100MHz_dB"]
rows = [",".join(cols)]
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
def meas(fn, name):
    try: txt = open(fn, errors="ignore").read()
    except OSError: return None
    m = re.search(r"^\s*" + name + r"\s*=\s*([-+0-9.eE]+)", txt, re.M | re.I)
    return float(m.group(1)) if m else None
missing = []
for c in "tt ss ff sf fs".split():
  for t in (-20, 27, 85):
    tag = f"{c}_{t}"; S = f"results_dc/{stage}/sweeps/"; L = f"results_dc/{stage}/log_"
    if not (os.path.exists(S + f"ron_{tag}.txt") and os.path.exists(S + f"leak_{tag}.txt")): missing.append(tag); continue
    d = np.loadtxt(S + f"ron_{tag}.txt"); x = d[:, 0]; cur = np.abs(d[:, 1]); ron = 0.1 / np.maximum(cur, 1e-30)
    at = [float(np.interp(float(v.replace("p", ".")), x, ron)) for v in VS]
    win = (x >= 0.0999) & (x <= 1.7001); r = ron[win]; xw = x[win]
    leak = abs(np.atleast_2d(np.loadtxt(S + f"leak_{tag}.txt"))[0, 1]) * 1e9
    bw = meas(L + f"bw_{tag}.txt", "bw"); iso = meas(L + f"iso_{tag}.txt", "iso")
    rows.append(",".join([stage, c, str(t)] + [g(a) for a in at] + [g(r.max()), g(xw[r.argmax()]), g(r.min()), g(leak),
                g(bw / 1e6 if bw is not None else None), g(-iso if iso is not None else None)]))
if missing: print("NO DATA for:", " ".join(missing)); sys.exit(1)
open(f"results_dc/{stage}/dc.csv", "w").write("\n".join(rows) + "\n")
bad = [ln.split(",")[1:3] for ln in rows[1:] if "nan" in ln]
print(stage, len(rows) - 1, "rows" + (f"   WARNING: nan (bandwidth/isolation not measured) in {bad}" if bad else ""))
