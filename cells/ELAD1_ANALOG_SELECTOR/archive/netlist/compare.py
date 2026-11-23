import csv, math
def load(s):
    return {(r["corner"], r["temp"], r["kind"], r["name"]): r for r in csv.DictReader(open(f"results_dc/{s}/dc.csv"))}
P, C, R = load("pre"), load("postC"), load("postRC")
def f(x): return float(x)
def pct(a, b): return (b - a) / a * 100 if a else float("nan")
print("tt / 27 C   (switch and clamp rows show resistance in ohm; leak/idd rows show current in uA)")
print(f"{'kind':6s}{'name':26s}{'pre':>12s}{'postC':>12s}{'postRC':>12s}{'RC/pre %':>10s}")
for (c, t, k, n), r in P.items():
    if (c, t) != ("tt", "27"): continue
    key = "r_ohm" if k in ("sw", "clamp") else "i_uA"
    a, b, d = f(r[key]), f(C[(c, t, k, n)][key]), f(R[(c, t, k, n)][key])
    flag = "  <-- CHECK" if k in ("sw", "clamp") and abs(pct(a, d)) > 5 else ""
    print(f"{k:6s}{n:26s}{a:12.4g}{b:12.4g}{d:12.4g}{pct(a, d):10.2f}{flag}")
print("\nworst-case |RC vs pre| % over all 15 conditions (switch/clamp resistance)")
for kind in ("sw", "clamp"):
    w = max(((abs(pct(f(r["r_ohm"]), f(R[k]["r_ohm"]))), k[1], k[2], k[3]) for k, r in P.items() if k[2] == kind and f(r["r_ohm"]) == f(r["r_ohm"])))
    print(f"{kind:6s}{w[0]:8.2f} %   at {w[1]} {w[2]} {w[3]}")
