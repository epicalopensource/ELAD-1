#!/usr/bin/env bash
# Scaffold cells/<name>/ with the source layout the flow expects.
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
name=${1:-}
[[ $name =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]] || { echo "usage: make new-cell NAME=<identifier>" >&2; exit 2; }
d="$ROOT/cells/$name"
[[ ! -e $d ]] || { echo "cells/$name already exists" >&2; exit 1; }
mkdir -p "$d/schematic" "$d/layout" "$d/sim"
touch "$d/schematic/.gitkeep" "$d/layout/.gitkeep"
cat > "$d/sim/specs.txt" <<'EOF'
# Pass/fail limits for measurements printed by the testbench (.meas or `meas` in .control).
# <name>  <min|->  <max|->      SI suffixes allowed: f p n u m k meg g
# tpd      -        50p
EOF
cat <<EOF
created cells/$name
  draw:   cells/$name/schematic/$name.sch      (top = subcircuit with ipin/opin/iopin)
          cells/$name/schematic/$name.sym      (symbol for testbench use)
          cells/$name/schematic/tb_$name.sch   (testbench; outputs relative to cwd)
          cells/$name/layout/$name.gds         (top cell named exactly '$name', pins labelled)
  edit:   xschem --rcfile flow/xschemrc cells/$name/schematic/$name.sch
EOF
