# (C) Copyright 2023 - 2024 Xilinx, Inc.
# SPDX-License-Identifier: Apache-2.0

RM = rm -rf
VIVADO = $(XILINX_VIVADO)/bin/vivado
#JOBS ?= $(shell nproc)
JOBS ?= 4

#VIV_DESIGN = vek280_base
VIV_DESIGN = ved2302_rpiRx2l2_hdmiTx

VIV_PRJ_DIR = project
VIV_SCRIPTS_DIR = scripts

VIV_XSA = $(VIV_PRJ_DIR)/$(VIV_DESIGN).xsa
VIV_SRC = $(VIV_SCRIPTS_DIR)/main.tcl

ISP_DIR= ip/isp_single
ISP_IP = isppipeline.prj

ISP_SRC = $(ISP_DIR)/build_isp/xf_config_params.h

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make xsa'
	@echo '    Generate extensible xsa for platform generation'
	@echo ''

.PHONY: all
all: xsa

$(ISP_IP): $(IP_SRC)
	make -C $(ISP_DIR) ip XPART=xcve2302-sfva784-1LP-e-S-es1

xsa: $(ISP_IP) $(VIV_XSA)

$(VIV_XSA): $(VIV_SRC)
	$(VIVADO) -mode batch -notrace -source $(VIV_SRC) -tclargs -jobs $(JOBS)
	#$(VIVADO) -mode gui -notrace -source $(VIV_SRC) -tclargs -jobs $(JOBS)
	
.PHONY: clean
clean:
	$(RM) $(VIV_PRJ_DIR) vivado* .Xil *dynamic* *.log *.xpe .crashReporter/
