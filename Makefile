PROJ_PATH = $(shell pwd)
SHELL := /bin/bash
YOSYS_HOME ?= /home/hniii98/Project/ysyx/yosys-sta

O ?= $(PROJ_PATH)/result
SDC_FILE ?= $(YOSYS_HOME)/scripts/default.sdc
DESIGN ?= $(TOPNAME)
RTL_FILES ?= $(shell find vsrc/ -name "*.v")
export CLK_FREQ_MHZ ?= 500
export CLK_PORT_NAME ?= clk
PDK = nangate45

RESULT_DIR = $(O)/$(DESIGN)-$(CLK_FREQ_MHZ)MHz
SCRIPT_DIR = $(YOSYS_HOME)/scripts
NETLIST_SYN_V   = $(RESULT_DIR)/$(DESIGN).netlist.syn.v
NETLIST_FIXED_V = $(RESULT_DIR)/$(DESIGN).netlist.fixed.v
TIMING_RPT = $(RESULT_DIR)/$(DESIGN).rpt


syn: $(NETLIST_SYN_V)
$(NETLIST_SYN_V): $(RTL_FILES) $(SCRIPT_DIR)/yosys.tcl
	mkdir -p $(@D)
	echo tcl $(SCRIPT_DIR)/yosys.tcl $(DESIGN) $(PDK) \"$(RTL_FILES)\" $@ | yosys -l $(@D)/yosys.log -s -

fix-fanout: $(NETLIST_FIXED_V)
$(NETLIST_FIXED_V): $(SCRIPT_DIR)/fix-fanout.tcl $(SDC_FILE) $(NETLIST_SYN_V)
	set -o pipefail && $(YOSYS_HOME)/bin/iEDA -script $^ $(DESIGN) $(PDK) $@ 2>&1 | tee $(RESULT_DIR)/fix-fanout.log 
	echo tcl $(SCRIPT_DIR)/yosys-area.tcl $(DESIGN) $(PDK) $@ | yosys -l $(@D)/yosys-fixed.log -s -

sta: $(TIMING_RPT)
$(TIMING_RPT): $(SCRIPT_DIR)/sta.tcl $(SDC_FILE) $(NETLIST_FIXED_V)
	set -o pipefail && $(YOSYS_HOME)/bin/iEDA -script $^ $(DESIGN) $(PDK) 2>&1 | tee $(RESULT_DIR)/sta.log


.PHONY:  syn fix-fanout sta clean