#!/usr/bin/env bash
# Check that the ELAD1_CONTROL .subckt ports are in the same order as the xschem symbol pins
# (xschem connects an instance POSITIONALLY in symbol pin order). Run in the project folder.
#   bash cells/ELAD1_CONTROL/harden/check_ports.sh
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")/../../.."
python3 - <<'PY'
import re, sys
sys.path.insert(0, 'flow/lib')
from gl2spice import read_sym_pins
sym = read_sym_pins('cells/ELAD1_CONTROL/schematic/ELAD1_CONTROL.sym')
bad = 0
for f in ('cells/ELAD1_CONTROL/synth/ELAD1_CONTROL.spice', 'cells/ELAD1_CONTROL/synth/ELAD1_CONTROL_lvs.spice'):
    try:
        txt = open(f).read()
    except FileNotFoundError:
        print(f'  {f}: missing'); continue
    m = re.search(r'^\.subckt\s+ELAD1_CONTROL\s+(.*(?:\n\+.*)*)', txt, re.M | re.I)
    ports = m.group(1).replace('\n+', ' ').split()
    if ports == sym:
        print(f'  OK        {f}  ({len(ports)} ports in symbol order)')
    else:
        bad = 1
        print(f'  MISMATCH  {f}')
        for i, (a, b) in enumerate(zip(sym, ports), 1):
            if a != b:
                print(f'     position {i}: symbol pin {a:<10} <- subckt port {b}')
sys.exit(bad)
PY
