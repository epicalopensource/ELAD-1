import csv
def load(s): return {(r["corner"], r["temp"]): r for r in csv.DictReader(open(f"results/{s}/dc.csv"))}
P, C, R = load("pre"), load("postC"), load("postRC")
keys = ["isub_pk_uA","isub_pp_uA","isub_rms_uA","isub_avg_uA","idd_avg_uA","idd_pk_uA","t_peak_ps","isub_pp_off_uA","idd_avg_off_uA"]
print("tt / 27 C")
print(f"{'metric':18s}{'pre':>12s}{'postC':>12s}{'postRC':>12s}{'RC vs pre %':>14s}")
for k in keys:
    a, b, c = (float(X[("tt","27")][k]) for X in (P, C, R))
    print(f"{k:18s}{a:12.4g}{b:12.4g}{c:12.4g}{(c-a)/a*100 if a else float('nan'):14.1f}")
print("\nworst-case |RC vs pre| % over all 15 conditions")
for k in keys:
    w = max(abs((float(R[x][k]) - float(P[x][k])) / float(P[x][k]) * 100) for x in P if float(P[x][k]))
    print(f"{k:18s}{w:10.1f}")
