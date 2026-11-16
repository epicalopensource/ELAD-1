import os, sys, numpy as np
stage = sys.argv[1]
T0, T1, TE = 20e-9, 60e-9, 21.05e-9      # window; first clock 50% edge inside it
cols = ["stage","corner","temp","isub_pk_uA","isub_pp_uA","isub_rms_uA","isub_avg_uA",
        "idd_avg_uA","idd_pk_uA","t_peak_ps","isub_pp_off_uA","idd_avg_off_uA"]
rows = [",".join(cols)]
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
def load(fn):
    d = np.loadtxt(fn); tg = np.arange(T0, T1, 10e-12)
    isub = np.interp(tg, d[:, 0], d[:, 3]) * 1e6        # uA, positive = leaving SUBI into the source
    idd = -np.interp(tg, d[:, 0], d[:, 5]) * 1e6         # uA, supply current
    return tg, isub, idd
missing = []
for c in "tt ss ff sf fs".split():
  for t in (-20, 27, 85):
    tag = f"{c}_{t}"; S = f"results/{stage}/sweeps/"
    if not (os.path.exists(S + f"on_{tag}.txt") and os.path.exists(S + f"off_{tag}.txt")):
        missing.append(tag); continue
    tg, i, dd = load(S + f"on_{tag}.txt"); _, io, ddo = load(S + f"off_{tag}.txt")
    m = (tg >= 21e-9) & (tg < 31e-9); k = np.argmax(np.abs(i[m]))
    tpk = (tg[m][k] - TE) * 1e12
    rows.append(",".join([stage, c, str(t), g(np.max(np.abs(i))), g(i.max() - i.min()),
        g(np.sqrt(np.mean(i**2))), g(np.mean(i)), g(np.mean(dd)), g(np.max(dd)), g(tpk),
        g(io.max() - io.min()), g(np.mean(ddo))]))
if missing:
    print("NO DATA for:", " ".join(missing), "- see results/%s/log_<tag>.txt" % stage); sys.exit(1)
open(f"results/{stage}/dc.csv", "w").write("\n".join(rows) + "\n")
print(stage, len(rows) - 1, "rows")
