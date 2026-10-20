#!/usr/bin/env python3
"""Count violations in KLayout report databases (.lyrdb).

usage: drc_count.py --out summary.json a.lyrdb [b.lyrdb ...]
Prints the total to stdout; writes per-category counts to --out. Streams the XML, so very
large databases do not need to fit in memory.
"""
import argparse
import json
import sys
import xml.etree.ElementTree as ET
from collections import Counter


def count(path):
    cats, total = Counter(), 0
    for _ev, el in ET.iterparse(path, events=("end",)):
        if el.tag == "item":
            cat = (el.findtext("category") or "?").strip().strip("'").replace("'.'", ".")
            cats[cat] += 1
            total += 1
            el.clear()
    return total, cats


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", required=True)
    ap.add_argument("dbs", nargs="+")
    a = ap.parse_args()
    grand, allcats, files = 0, Counter(), {}
    for db in a.dbs:
        try:
            t, c = count(db)
        except ET.ParseError as e:
            print(f"error: {db}: {e}", file=sys.stderr)
            sys.exit(2)
        grand += t
        allcats.update(c)
        files[db] = t
    with open(a.out, "w") as f:
        json.dump({"total": grand, "by_rule": dict(allcats.most_common(100)), "files": files}, f, indent=2)
    print(grand)


if __name__ == "__main__":
    main()
