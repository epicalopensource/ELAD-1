# KLayout batch script — derive an LVS verdict from a .lvsdb cross-reference.
#   klayout -b -r lvsdb_check.py -rd lvsdb=<file>
# Prints LVS_RESULT=MATCH|MISMATCH|UNKNOWN and LVS_DETAIL=<text>.
#
# Why not trust the deck's console output? Wording differs per PDK deck and release; the
# database is the deck-independent ground truth. UNKNOWN is never treated as clean.
import pya


def _v(x):
    return x() if callable(x) else x


try:
    lvs = pya.LayoutVsSchematic()
    lvs.read(lvsdb)  # noqa: F821  (defined by klayout -rd)
    xref = lvs.xref()
    if xref is None:
        raise RuntimeError("no cross-reference in database (compare step not run?)")
    X = pya.NetlistCrossReference
    good = [X.Match, X.MatchWithWarning]
    pairs = list(xref.each_circuit_pair())
    if not pairs:
        raise RuntimeError("cross-reference has no circuit pairs")
    bad = []
    for p in pairs:
        a, b = _v(p.first), _v(p.second)
        name = (a or b).name if (a or b) else "?"
        st = _v(p.status)
        if not any(st == g for g in good):
            bad.append(f"{name}:{st}")
    print("LVS_DETAIL=" + ("; ".join(bad) if bad else "all circuits match"))
    print("LVS_RESULT=" + ("MISMATCH" if bad else "MATCH"))
except Exception as e:  # noqa: BLE001 — any failure must yield UNKNOWN, never MATCH
    print("LVS_DETAIL=" + str(e).replace("\n", " "))
    print("LVS_RESULT=UNKNOWN")
