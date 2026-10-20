#!/usr/bin/env bash
# One-time: add the analog flow to a repository created from TinyTapeout/ttsky-analog-template.
# Idempotent: safe to run again. Run from the repository root, in Ubuntu (needs git + git-lfs).
set -euo pipefail
ROOT=$(cd "$(dirname "$(readlink -f "$0")")/../.." && pwd)
cd "$ROOT"
[[ -f info.yaml && -f src/project.v && -f .github/workflows/gds.yaml ]] || {
  echo "setup: this does not look like a Tiny Tapeout template repository (info.yaml, src/project.v, .github/workflows/gds.yaml)" >&2; exit 2; }
command -v git-lfs >/dev/null || { echo "setup: git-lfs missing (sudo apt install -y git-lfs)" >&2; exit 2; }

chmod +x flow/*.sh flow/stages/*.sh flow/lib/*.py flow/tt/*.sh flow/tt/*.py flow/tt/kpy ci/*.sh 2>/dev/null || true

marker="# --- analog flow: generated results"
if ! grep -qF "$marker" .gitignore 2>/dev/null; then
  { echo; cat flow/tt/gitignore.flow; } >> .gitignore
  echo "setup: .gitignore extended"
fi
if ! grep -qF "cells/**/*.gds" .gitattributes 2>/dev/null; then
  { [[ -s .gitattributes ]] && echo; cat flow/tt/gitattributes.flow; } >> .gitattributes
  echo "setup: .gitattributes written (LFS for cells/**/*.gds only)"
fi
git lfs install --local >/dev/null
mkdir -p cells gds lef
echo "setup: done. Next (EDA box): make tt-init TOP=tt_um_<you>_<project>"
