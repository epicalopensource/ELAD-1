#!/usr/bin/env bash
# Environment self-check: tools, versions, PDK, and every PDK path the adapter resolves.
# Run this first in any new environment (container tag bump, PDK update): most "the flow is
# broken" reports are a deck path or -rd variable that moved between PDK releases.
set -uo pipefail
# shellcheck source=lib/env.sh
source "$(dirname "$(readlink -f "$0")")/lib/env.sh"
bad=0
ok()   { printf '  \033[32mOK\033[0m   %-22s %s\n' "$1" "$2"; }
warn() { printf '  \033[33mWARN\033[0m %-22s %s\n' "$1" "$2"; }
err()  { printf '  \033[31mFAIL\033[0m %-22s %s\n' "$1" "$2"; bad=1; }

echo "Config: PDK=$PDK PDK_ROOT=$PDK_ROOT LVS_ENGINE=$LVS_ENGINE PEX_MODE=$PEX_MODE STRICT_GATE=$STRICT_GATE POSTSIM=$POSTSIM"
echo "Tools:"
for t in xschem ngspice klayout magic python3 make; do
  if p=$(command -v "$t"); then ok "$t" "$p"; else err "$t" "not on PATH"; fi
done
if command -v netgen >/dev/null; then ok netgen "$(command -v netgen)"
elif [[ $LVS_ENGINE == netgen ]]; then err netgen "required by LVS_ENGINE=netgen"; else warn netgen "absent (only needed for LVS_ENGINE=netgen)"; fi
command -v inotifywait >/dev/null && ok inotifywait "watch mode: instant events" || warn inotifywait "watch mode will poll"
command -v flock >/dev/null && ok flock "run locking" || warn flock "no run locking"
command -v klayout >/dev/null && echo "         klayout: $(timeout 10 klayout -v 2>&1 | head -n1)"
command -v ngspice >/dev/null && echo "         ngspice: $(timeout 10 ngspice -v 2>&1 | grep -m1 -i ngspice)"

echo "PDK ($PDK_DIR):"
[[ -d $PDK_DIR ]] && ok "PDK dir" "$PDK_DIR" || err "PDK dir" "missing — set PDK/PDK_ROOT"
x="$PDK_DIR/libs.tech/xschem/xschemrc"; [[ -f $x ]] && ok xschemrc "$x" || err xschemrc "missing $x"
p=$(pdk_magicrc)      && ok magicrc "$p"      || err magicrc "not found"
p=$(pdk_ngspice_init) && ok "ngspice init" "$p" || warn "ngspice init" "none (ok if the PDK does not need one)"
p=$(pdk_netgen_setup) && ok "netgen setup" "$p" || warn "netgen setup" "not found"
if declare -F pdk_drc_deck >/dev/null; then
  p=$(pdk_drc_deck) && ok "KLayout DRC deck" "$p" || err "KLayout DRC deck" "not found (set KLAYOUT_DRC_DECK)"
  if p=$(pdk_lvs_deck); then ok "KLayout LVS deck" "$p"
  elif [[ $LVS_ENGINE == klayout ]]; then err "KLayout LVS deck" "not found — set KLAYOUT_LVS_DECK or LVS_ENGINE=netgen"
  else warn "KLayout LVS deck" "not found (LVS_ENGINE=netgen in use)"; fi
else
  echo "  (adapter $FLOW_PDK_ADAPTER uses python runners; see flow/pdk/$FLOW_PDK_ADAPTER.sh)"
  for r in "$PDK_DIR"/libs.tech/klayout/{drc,lvs,tech/drc,tech/lvs}/run_*.py; do [[ -f $r ]] && ok runner "$r"; done
fi

echo "Cells:"
for d in "$FLOW_ROOT"/cells/*/; do
  c=$(basename "$d"); [[ $c == _* ]] && continue
  printf '  %-16s sch:%s tb:%s gds:%s specs:%s\n' "$c" \
    "$([[ -f $d/schematic/$c.sch ]] && echo y || echo -)" "$([[ -f $d/schematic/tb_$c.sch ]] && echo y || echo -)" \
    "$([[ -f $d/layout/$c.gds ]] && echo y || echo -)" "$([[ -f $d/sim/specs.txt ]] && echo y || echo -)"
done
exit $bad
