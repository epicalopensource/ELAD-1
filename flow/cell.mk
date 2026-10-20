# flow/cell.mk — dependency graph for ONE cell.
#   make -f flow/cell.mk CELL=<name> [-j N] [-k]        (normally via the top Makefile)
#
#                      ┌─> netlist/<c>.spice ──┬──> LVS ──(STRICT_GATE)──┐
#  schematic/<c>.sch ──┘                       │                         v
#                                              └───────────────────────> PEX ──┐
#  layout/<c>.gds ──┬──> DRC                                ^                  │
#                   └──> LVS, PEX ───────────────────────────┘                 v
#  schematic/tb_<c>.sch ─> netlist/tb_<c>.spice ──> SIM            POSTSIM (tb + PEX)
#
# Independent branches (SIM | DRC | LVS | PEX when STRICT_GATE=0) run concurrently under -j.
# Each stage is represented by a stamp in .stamps/ that exists only after success, so an
# interrupted or failed stage is always retried, and an unchanged input never re-runs a stage.

FLOW_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
include $(FLOW_ROOT)/flow.conf
.DEFAULT_GOAL := all

ifndef CELL
$(error CELL is not set: make -f flow/cell.mk CELL=<name>)
endif

C   := $(FLOW_ROOT)/cells/$(CELL)
STG := $(FLOW_ROOT)/flow/stages
LIB := $(FLOW_ROOT)/flow/lib
ST  := $(C)/.stamps

SCH   := $(C)/schematic/$(CELL).sch
TBSCH := $(C)/schematic/tb_$(CELL).sch
GDS   := $(C)/layout/$(CELL).gds
NET   := $(C)/netlist/$(CELL).spice
TBNET := $(C)/netlist/tb_$(CELL).spice
SPECS := $(wildcard $(C)/sim/specs.txt)

# Conservative hierarchy tracking: any project schematic/symbol may be instantiated by this
# cell. Over-triggering costs one ~1 s netlist run; content comparison in netlist.sh stops the
# cascade, so correctness is gained without paying for unnecessary LVS/PEX/sim runs.
SCH_DEPS := $(wildcard $(FLOW_ROOT)/cells/*/schematic/*.sch $(FLOW_ROOT)/cells/*/schematic/*.sym) \
            $(FLOW_ROOT)/flow/xschemrc
RUNTIME  := $(LIB)/common.sh $(LIB)/env.sh $(wildcard $(FLOW_ROOT)/flow/pdk/*.sh)

# ---- configuration stamps -------------------------------------------------------------
# Changing a knob (e.g. PEX_MODE=c on the command line) must re-run exactly the stages that
# consume it. Each stamp is rewritten only when its content changes, so its mtime encodes
# "this configuration last changed at".
define cfg_rule
$(ST)/config.$(1): FORCE | $(ST)
	@printf '%s\n' $(foreach v,$(2),'$(v)=$($(v))') > $$@.tmp
	@if cmp -s $$@.tmp $$@; then rm -f $$@.tmp; else mv -f $$@.tmp $$@; fi
endef
$(eval $(call cfg_rule,pdk,PDK PDK_ROOT))
$(eval $(call cfg_rule,verify,LVS_ENGINE KLAYOUT_DRC_DECK KLAYOUT_LVS_DECK KLAYOUT_LVS_OPTS))
$(eval $(call cfg_rule,pex,PEX_MODE PEX_RES_TOLERANCE PEX_PORT_ALIAS))

# ---- which stages apply depends on which sources exist ----------------------------------
TARGETS :=
ifneq ($(wildcard $(SCH)),)
  TARGETS += $(ST)/netlist_lvs.ok
endif
ifneq ($(wildcard $(TBSCH)),)
  TARGETS += $(ST)/sim.ok
endif
ifneq ($(wildcard $(GDS)),)
  TARGETS += $(ST)/drc.ok
  ifneq ($(wildcard $(SCH)),)
    TARGETS += $(ST)/lvs.ok $(ST)/pex.ok
    ifneq ($(wildcard $(TBSCH)),)
      ifeq ($(POSTSIM),1)
        TARGETS += $(ST)/postsim.ok
      endif
    endif
  endif
endif

.PHONY: all FORCE
all: $(TARGETS)
	@echo "[$(CELL)] all applicable stages up to date"
FORCE:
$(ST):
	@mkdir -p $@

# ---- netlists: stamp = "netlisting ran OK"; the .spice changes only on semantic change ----
$(ST)/netlist_lvs.ok: $(SCH) $(SCH_DEPS) $(STG)/netlist.sh $(RUNTIME) $(ST)/config.pdk | $(ST)
	@$(STG)/netlist.sh $(CELL) lvs
	@touch $@
$(NET): $(ST)/netlist_lvs.ok ;

$(ST)/netlist_tb.ok: $(TBSCH) $(SCH_DEPS) $(STG)/netlist.sh $(RUNTIME) $(ST)/config.pdk | $(ST)
	@$(STG)/netlist.sh $(CELL) tb
	@touch $@
$(TBNET): $(ST)/netlist_tb.ok ;

# ---- simulation (pre-layout) ----------------------------------------------------------------
$(ST)/sim.ok: $(TBNET) $(SPECS) $(STG)/sim.sh $(LIB)/spice_tools.py $(RUNTIME) $(ST)/config.pdk | $(ST)
	@$(STG)/sim.sh $(CELL) pre
	@touch $@

# ---- physical verification -----------------------------------------------------------------
$(ST)/drc.ok: $(GDS) $(STG)/drc.sh $(LIB)/drc_count.py $(LIB)/gds_topcells.py $(RUNTIME) \
              $(ST)/config.pdk $(ST)/config.verify | $(ST)
	@$(STG)/drc.sh $(CELL)
	@touch $@

$(ST)/lvs.ok: $(GDS) $(NET) $(STG)/lvs.sh $(LIB)/lvsdb_check.py $(LIB)/gds_topcells.py $(RUNTIME) \
              $(ST)/config.pdk $(ST)/config.verify | $(ST)
	@$(STG)/lvs.sh $(CELL)
	@touch $@

# ---- parasitic extraction ----------------------------------------------------------------
PEX_GATE := $(if $(filter 1,$(STRICT_GATE)),$(ST)/lvs.ok)
$(ST)/pex.ok: $(GDS) $(NET) $(PEX_GATE) $(STG)/pex.sh $(LIB)/spice_tools.py $(RUNTIME) \
              $(ST)/config.pdk $(ST)/config.pex | $(ST)
	@$(STG)/pex.sh $(CELL)
	@touch $@

# ---- post-layout simulation ---------------------------------------------------------------
$(ST)/postsim.ok: $(ST)/pex.ok $(TBNET) $(SPECS) $(STG)/sim.sh $(LIB)/spice_tools.py $(RUNTIME) | $(ST)
	@$(STG)/sim.sh $(CELL) post
	@touch $@
