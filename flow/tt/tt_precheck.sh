#!/usr/bin/env bash
# Run Tiny Tapeout's OWN precheck (tt-support-tools/precheck/precheck.py) on this repository,
# the same checks TT's 'gds' GitHub Action runs: Magic DRC, KLayout FEOL/BEOL/offgrid, pin,
# boundary, power pin, layer, cell name, urpm/nwell, analog pin, Verilog syntax.
#
# Differences from TT's Action (so a PASS here is a strong, not a final, indication):
#   * tools: this box's magic and klayout instead of TT's Nix-pinned versions
#   * PDK:   this box's sky130A ($PDK_ROOT) instead of TT's pinned version
# The authoritative result is the 'gds' workflow on GitHub (precheck job).
#
# Needs internet the first time (git clone + pip into .tt/venv); later runs are offline.
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/../.." && pwd)
cd "$ROOT"
conf() { sed -nE "s/^[[:space:]]*$1[[:space:]]*\\?=[[:space:]]*(.*[^[:space:]])[[:space:]]*\$/\\1/p" flow.conf | tail -n1; }
REF=${TT_TOOLS_REF:-$(conf TT_TOOLS_REF)}
TOP=$(sed -nE 's/^[[:space:]]*top_module:[[:space:]]*"([^"]*)".*/\1/p' info.yaml)
: "${PDK_ROOT:?PDK_ROOT not set: run inside the EDA box}"
PDK=${PDK:-sky130A}
[[ $PDK == sky130A ]] || { echo "tt-precheck: PDK=$PDK, expected sky130A" >&2; exit 2; }
command -v magic >/dev/null && command -v klayout >/dev/null || { echo "tt-precheck: needs magic and klayout (EDA box)" >&2; exit 2; }
for f in "gds/$TOP.gds" "lef/$TOP.lef" src/project.v; do
  [[ -f $f ]] || { echo "tt-precheck: $f missing (run: make tt)" >&2; exit 2; }
done

TT=$ROOT/.tt
mkdir -p "$TT"
if [[ ! -d $TT/tt-support-tools/.git ]]; then
  git clone -q https://github.com/TinyTapeout/tt-support-tools.git "$TT/tt-support-tools"
fi
git -C "$TT/tt-support-tools" fetch -q origin "$REF" 2>/dev/null || true
git -C "$TT/tt-support-tools" -c advice.detachedHead=false checkout -q "$REF"
if [[ ! -x $TT/venv/bin/python ]]; then
  python3 -m venv "$TT/venv"
  if ! "$TT/venv/bin/pip" install -q -r "$TT/tt-support-tools/precheck/requirements.txt"; then
    # TT pins exact versions; if one has no wheel for this Python, use current releases.
    echo "tt-precheck: pinned requirements failed to install; using current releases" >&2
    "$TT/venv/bin/pip" install -q gdstk klayout pyyaml yowasp-yosys numpy
  fi
fi

# The same layout the TT Action builds: tt_submission/<top>.{gds,lef,v}
rm -rf tt_submission && mkdir -p tt_submission
cp "gds/$TOP.gds" "lef/$TOP.lef" tt_submission/
cp src/project.v "tt_submission/$TOP.v"

cd "$TT/tt-support-tools/precheck"
mkdir -p reports
echo "tt-precheck: tt-support-tools $REF, PDK $PDK_ROOT/$PDK ($(readlink -f "$PDK_ROOT/$PDK" | grep -oE '[0-9a-f]{40}' || echo '?')), $(magic --version 2>/dev/null | head -1 || true)"
set +e
PATH=$TT/venv/bin:$PATH PDK_ROOT=$PDK_ROOT PDK=$PDK "$TT/venv/bin/python" precheck.py --gds "$ROOT/tt_submission/$TOP.gds" --tech sky130A
rc=$?
set -e
echo
cat reports/results.md 2>/dev/null || true
echo
echo "tt-precheck: reports in $TT/tt-support-tools/precheck/reports/"
exit $rc
