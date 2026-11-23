import csv
def load(s): return {(r["corner"], r["temp"]): r for r in csv.DictReader(open(f"results_dc/{s}/dc.csv"))}
P, C, R = load("pre"), load("postC"), load("postRC")
keys = ["ron_0p1V_ohm","ron_0p5V_ohm","ron_0p9V_ohm","ron_1p3V_ohm","ron_1p7V_ohm","ron_max_ohm","ron_min_ohm","leak_nA","bw_MHz","off_iso_100MHz_dB"]
print("tt / 27 C")
print(f"{'metric':22s}{'pre':>12s}{'postC':>12s}{'postRC':>12s}{'RC vs pre':>12s}")
for k in keys:
    a, b, c = (float(X[("tt","27")][k]) for X in (P, C, R))
    d = (c - a) if k.startswith("off_iso") else ((c - a) / a * 100 if a else float("nan"))
    print(f"{k:22s}{a:12.4g}{b:12.4g}{c:12.4g}{d:11.2f}{' dB' if k.startswith('off_iso') else ' %'}")
print("\nworst case over the 15 conditions (RC vs pre): max |%| for R_on and bandwidth, min change (dB) for isolation")
for k in ["ron_max_ohm","ron_0p1V_ohm","ron_0p9V_ohm","bw_MHz"]:
    print(f"{k:22s}{max(abs((float(R[x][k]) - float(P[x][k])) / float(P[x][k]) * 100) for x in P):10.2f} %")
print(f"{'off_iso_100MHz_dB':22s}{min(float(R[x]['off_iso_100MHz_dB']) - float(P[x]['off_iso_100MHz_dB']) for x in P):10.2f} dB")
