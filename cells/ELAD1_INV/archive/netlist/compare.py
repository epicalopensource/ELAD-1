import csv
def load(s): return {(r["corner"], r["temp"]): r for r in csv.DictReader(open(f"results_tr/{s}/tr.csv"))}
P, C, R = load("pre"), load("postC"), load("postRC")
keys = ["func_err","bad_cycles","extra_edges","voh_min_V","vol_max_V","tpd_max_ns","tpd_avg_ns","tpd_agg_ns","slew_max_ns","iavg_uA","ipk_mA","e_pJ_per_cycle","ileak_nA"]
conds = [c for c in P if c in C and c in R]
for cd in conds:
    print(f"\n{cd[0]} / {cd[1]} C")
    print(f"{'metric':16s}{'pre':>12s}{'postC':>12s}{'postRC':>12s}{'RC vs pre %':>14s}")
    for k in keys:
        a, b, c = (float(X[cd][k]) for X in (P, C, R))
        print(f"{k:16s}{a:12.4g}{b:12.4g}{c:12.4g}{(c-a)/a*100 if a else float('nan'):14.2f}")
