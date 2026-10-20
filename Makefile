# Top-level entry point.
#   make                     run the whole flow for every cell (parallel) + report
#   make CELLS="inv ota"     restrict to some cells
#   make inv                 one cell's DAG only (no report, no lock)
#   make watch               re-run automatically when schematics / GDS are saved
#   make doctor              check tools, PDK, decks inside the current environment
#   make new-cell NAME=ota   scaffold a cell folder
#   make docker-flow         run the flow inside the pinned container (local == CI)
#   make import-spice NETLIST=ota.spice [ALL=1] [STYLE=bus|labels]  SPICE netlist -> xschem .sch + .sym
# Tiny Tapeout (repository created from TinyTapeout/ttsky-analog-template):
#   make tt-init TOP=tt_um_<you>_<name>   name the project, create the top-level layout shell
#   make tt                  verify every cell, export gds/ + lef/, check all TT rules
#   make tt-check            TT rule check only (no flow run, no export)
#   make tt-precheck         Tiny Tapeout's own precheck, locally (needs internet once)
#   make tt-rename NEW=tt_um_<you>_<name>  rename the project everywhere
#   make tt-wire PIN=ua[0]   draw a met4 lead from an analog pin (marks it used for TT)

FLOW_ROOT := $(abspath .)
include flow.conf

ALL_CELLS := $(sort $(filter-out _%,$(notdir $(patsubst %/,%,$(wildcard cells/*/)))))
CELLS ?= $(ALL_CELLS)

.DEFAULT_GOAL := flow
.PHONY: flow cells $(ALL_CELLS) report doctor watch new-cell docker-flow clean help import-spice \
        tt-init tt tt-export tt-check tt-precheck tt-rename tt-wire

flow:            ## parallel run (make -k -j) + always-run report; non-zero exit on any failure
	@flow/run.sh $(CELLS)

cells: $(CELLS)

$(ALL_CELLS):
	+@$(MAKE) --no-print-directory -f flow/cell.mk CELL=$@

report:
	@python3 flow/lib/report.py $(CELLS)

doctor:
	@flow/doctor.sh

watch:
	@flow/watch.sh

new-cell:
	@flow/new_cell.sh $(NAME)

docker-flow:
	@flow/docker.sh flow/run.sh $(CELLS)

import-spice:    ## make import-spice NETLIST=<file> [ALL=1] [FORCE=1] [STYLE=pro|bus|labels] [SUBCKT="a b"]
	@test -n "$(NETLIST)" || { echo "usage: make import-spice NETLIST=<file.spice> [ALL=1] [FORCE=1]"; exit 2; }
	@python3 flow/lib/sch_from_spice.py "$(NETLIST)" $(SUBCKT) --cells $(if $(ALL),--all) $(if $(FORCE),--force) $(if $(STYLE),--style $(STYLE))

clean:           ## remove generated results (sources: schematic/, layout/, sim/specs.txt are kept)
	@for c in $(CELLS); do \
	  rm -rf cells/$$c/netlist cells/$$c/verify cells/$$c/pex cells/$$c/reports cells/$$c/.stamps \
	         cells/$$c/sim/results cells/$$c/sim/postlayout; \
	done; rm -rf reports; echo "cleaned: $(CELLS)"

# ---- Tiny Tapeout ------------------------------------------------------------------------------
TT_TOP = $(shell sed -nE 's/^[[:space:]]*top_module:[[:space:]]*"([^"]*)".*/\1/p' info.yaml 2>/dev/null)
KPY := flow/tt/kpy
export TT_REQUIRE_TIEOFF TT_STRIPE_W TT_TIEOFF

tt-init:
	@$(KPY) flow/tt/tt_init.py init $(TOP)

tt-export:
	@test -n "$(TT_TOP)" || { echo "no info.yaml / top_module: is this a Tiny Tapeout repository?"; exit 2; }
	@$(KPY) flow/tt/tt_export.py cells/$(TT_TOP)/layout/$(TT_TOP).gds gds/$(TT_TOP).gds lef/$(TT_TOP).lef

tt: ## the one command before committing a submission state
	@flow/run.sh
	@$(MAKE) --no-print-directory tt-export
	@$(KPY) flow/tt/tt_check.py

tt-check:
	@$(KPY) flow/tt/tt_check.py

tt-precheck:
	@flow/tt/tt_precheck.sh

tt-rename:
	@$(KPY) flow/tt/tt_init.py rename $(NEW)

tt-wire: ## met4 lead from an analog pin: make tt-wire PIN=ua[0]
	@test -n "$(PIN)" || { echo "usage: make tt-wire PIN=ua[0]"; exit 2; }
	@$(KPY) flow/tt/tt_shell.py stub cells/$(TT_TOP)/layout/$(TT_TOP).gds '$(PIN)' $(LEN)

help:
	@sed -n '2,16p' Makefile
