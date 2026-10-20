# shellcheck shell=bash
# env.sh — establishes FLOW_ROOT, loads flow.conf defaults, loads the PDK adapter.
# Sourced (never executed). Safe to source outside the container (no hard checks here;
# stages and `make doctor` do the validation).

FLOW_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export FLOW_ROOT

# Load `KEY ?= value` lines; a variable already present in the environment wins
# (mirrors GNU Make's `?=` so Make and bash always agree on the effective config).
_flow_load_conf() {
  local line key val re='^[[:space:]]*([A-Z_][A-Z0-9_]*)[[:space:]]*\?=[[:space:]]*(.*)$'
  while IFS= read -r line || [[ -n $line ]]; do
    [[ $line =~ $re ]] || continue
    key=${BASH_REMATCH[1]}
    val=${BASH_REMATCH[2]}
    val="${val%"${val##*[![:space:]]}"}"          # rtrim
    if [[ -z ${!key+x} ]]; then export "$key=$val"; fi
  done < "$FLOW_ROOT/flow.conf"
}
_flow_load_conf

# Some container images only put tools on PATH from their interactive shell start-up, which
# a batch `docker run --entrypoint bash` (CI, flow/docker.sh) skips. If any flow tool is
# missing but a /foss/tools tree exists, add its tool dirs (klayout has no bin/ subdir).
_flow_missing=0
for _t in xschem ngspice klayout magic; do command -v "$_t" >/dev/null 2>&1 || _flow_missing=1; done
if (( _flow_missing )) && [[ -d /foss/tools ]]; then
  for _d in /foss/tools/bin /foss/tools/*/bin /foss/tools/klayout /foss/tools/sak; do
    if [[ -d $_d && ":$PATH:" != *":$_d:"* ]]; then PATH="$PATH:$_d"; fi
  done
  export PATH
fi
unset _flow_missing _t _d

PDK_DIR="$PDK_ROOT/$PDK"
export PDK_DIR

# Echo the first argument that is a non-empty path to an existing file/dir.
first_existing() {
  local p
  for p in "$@"; do
    if [[ -n $p && -e $p ]]; then printf '%s\n' "$p"; return 0; fi
  done
  return 1
}

# PDK family -> adapter file. Variants (sky130A/B, gf180mcuC/D, ...) share one adapter.
case $PDK in
  sky130*)     FLOW_PDK_ADAPTER=sky130 ;;
  gf180mcu*)   FLOW_PDK_ADAPTER=gf180mcu ;;
  ihp-sg13g2*) FLOW_PDK_ADAPTER=ihp-sg13g2 ;;
  *)           FLOW_PDK_ADAPTER=$PDK ;;
esac
if [[ -f "$FLOW_ROOT/flow/pdk/$FLOW_PDK_ADAPTER.sh" ]]; then
  # shellcheck source=/dev/null
  source "$FLOW_ROOT/flow/pdk/$FLOW_PDK_ADAPTER.sh"
else
  echo "FLOW: no PDK adapter flow/pdk/$FLOW_PDK_ADAPTER.sh for PDK=$PDK" >&2
  return 2 2>/dev/null || exit 2
fi
