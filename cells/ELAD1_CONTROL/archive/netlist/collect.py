import os, sys, numpy as np
import stim
TRAPZ = getattr(np, "trapezoid", None) or np.trapz
stage = sys.argv[1]; conds = sys.argv[2].split()
V = float(os.environ.get("VDD", "1.8"))
OUTS = stim.OUTS; T = stim.T
EX = np.array([[int(ch) for ch in s] for s in stim.expected()])          # cycles x outputs
cols = ["stage","corner","temp","func_err","bad_cycles","extra_edges","voh_min_V","vol_max_V","tpd_max_ns","tpd_avg_ns",
        "tpd_agg_ns","slew_max_ns","iavg_uA","ipk_mA","e_pJ_per_cycle","ileak_nA"]
rows = [",".join(cols)]
def g(x): return "nan" if x is None or x != x else f"{x:.6g}"
def cr(t, v, lv, i, rising):          # time where v crosses lv between samples i and i+1
    return t[i] + (t[i + 1] - t[i]) * (lv - v[i]) / (v[i + 1] - v[i])
missing = []
for tag in conds:
    c, tp = tag.rsplit("_", 1); S = f"results_tr/{stage}/sweeps/"
    if not (os.path.exists(S + f"out_{tag}.txt") and os.path.exists(S + f"idd_{tag}.txt")): missing.append(tag); continue
    d = np.loadtxt(S + f"out_{tag}.txt"); t = d[:, 0] * 1e9; W = d[:, 1:]
    di = np.loadtxt(S + f"idd_{tag}.txt"); ti = di[:, 0] * 1e9; ii = -di[:, 1]
    # functional: sample each output SAMPLE ns after every rising edge
    bit = np.zeros((stim.NC, len(OUTS)), int); lev = np.zeros_like(bit, float)
    for k in range(stim.NC):
        ts = stim.rise(k) + stim.SAMPLE
        for j in range(len(OUTS)):
            v = float(np.interp(ts, t, W[:, j])); lev[k, j] = v; bit[k, j] = int(v > V / 2)
    wrong = bit != EX
    func_err = int(wrong.sum()); bad_cycles = int(wrong.any(axis=1).sum())
    hi = lev[EX == 1]; lo = lev[EX == 0]
    voh = float(hi.min()) if len(hi) else float("nan"); vol = float(lo.max()) if len(lo) else float("nan")
    # edges: every crossing of V/2, delay to the preceding clock edge, slew 10-90 %
    tpd = []; tagg = []; slew = []; nedge = 0
    for j, nm in enumerate(OUTS):
        v = W[:, j]; s = np.sign(v - V / 2); k = np.where(np.diff(s) != 0)[0]
        for i in k:
            te = cr(t, v, V / 2, i, v[i + 1] > v[i]); nedge += 1
            n = int((te - stim.T0) // T)
            if n < 0: continue
            dly = te - (stim.rise(n) + 0.05)
            (tagg if nm == "agg_clk" else tpd).append(dly)
            up = v[i + 1] > v[i]; a, b = (0.1 * V, 0.9 * V)
            lo_i = i
            while lo_i > 0 and ((v[lo_i] > a) if up else (v[lo_i] < b)): lo_i -= 1
            hi_i = i + 1
            while hi_i < len(v) - 1 and ((v[hi_i] < b) if up else (v[hi_i] > a)): hi_i += 1
            if up: slew.append(cr(t, v, b, hi_i - 1, True) - cr(t, v, a, lo_i, True))
            else: slew.append(cr(t, v, a, hi_i - 1, False) - cr(t, v, b, lo_i, False))
    exp_edges = int((np.diff(EX, axis=0) != 0).sum())
    extra = nedge - exp_edges
    ta, tb = stim.rise(0) - 5.0, stim.rise(stim.NC - 1) + T
    m = (ti >= ta) & (ti <= tb)
    iavg = float(TRAPZ(ii[m], ti[m]) / (tb - ta))                      # A
    ipk = float(ii[m].max())                                              # A
    e_pj = iavg * V * T * 1e3                                             # pJ per clock cycle
    q = (ti >= stim.TEND - 400.0) & (ti <= stim.TEND - 50.0)
    rows.append(",".join([stage, c, tp, str(func_err), str(bad_cycles), str(extra), g(voh), g(vol),
        g(max(tpd) if tpd else float("nan")), g(float(np.mean(tpd)) if tpd else float("nan")),
        g(float(np.mean(tagg)) if tagg else float("nan")), g(max(slew) if slew else float("nan")),
        g(iavg * 1e6), g(ipk * 1e3), g(e_pj), g(float(np.mean(ii[q])) * 1e9)]))
if missing:
    print("NO DATA for:", " ".join(missing)); sys.exit(1)
open(f"results_tr/{stage}/tr.csv", "w").write("\n".join(rows) + "\n")
print(stage, len(rows) - 1, "rows")
