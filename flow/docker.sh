#!/usr/bin/env bash
# Run a command inside the pinned EDA container — the SAME environment CI uses.
#   flow/docker.sh flow/run.sh inv          flow/docker.sh make doctor
#
# * repo mounted at the identical absolute path -> paths in logs/reports are valid on both sides
# * runs as the calling uid:gid -> generated files are owned by you, not root
# * HOME=/tmp -> tools that write ~/.xschem, ~/.klayout work for an arbitrary uid
# * entrypoint bypassed -> no VNC/desktop start-up in batch mode (env.sh repairs PATH if needed)
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
(( $# )) || { echo "usage: flow/docker.sh <command> [args...]" >&2; exit 2; }

# Read `KEY ?= value` from flow.conf (same rule as Make and flow/lib/env.sh).
conf() { sed -nE "s/^[[:space:]]*$1[[:space:]]*\\?=[[:space:]]*(.*[^[:space:]])[[:space:]]*\$/\\1/p" "$ROOT/flow.conf" | tail -n1; }

image=${FLOW_IMAGE:-$(conf FLOW_IMAGE)}
[[ -n $image ]] || { echo "FLOW_IMAGE not configured in flow.conf" >&2; exit 2; }

# The PDK is ALWAYS passed explicitly: the image sets its own default PDK in its environment
# (ihp-sg13g2 in 2026.09), which would otherwise silently override flow.conf in CI.
PDK=${PDK:-$(conf PDK)}
export PDK

# Forward flow knobs set by the caller. PDK_ROOT is deliberately NOT forwarded:
# a host path would be wrong inside the container (set CONTAINER_PDK_ROOT to override).
envs=()
for v in PDK LVS_ENGINE PEX_MODE PEX_RES_TOLERANCE PEX_PORT_ALIAS STRICT_GATE POSTSIM JOBS \
         KLAYOUT_DRC_DECK KLAYOUT_LVS_DECK KLAYOUT_LVS_OPTS NETLIST_TIMEOUT SIM_TIMEOUT DRC_TIMEOUT \
         LVS_TIMEOUT PEX_TIMEOUT CI; do
  if [[ -n ${!v+x} ]]; then envs+=(-e "$v"); fi
done
if [[ -n ${CONTAINER_PDK_ROOT:-} ]]; then envs+=(-e "PDK_ROOT=$CONTAINER_PDK_ROOT"); fi

tty=()
if [[ -t 0 && -t 1 ]]; then tty=(-it); fi

exec docker run --rm "${tty[@]}" \
  --user "$(id -u):$(id -g)" -e HOME=/tmp "${envs[@]}" \
  -v "$ROOT:$ROOT" -w "$ROOT" \
  --entrypoint /bin/bash "$image" -c '"$@"' flow "$@"
