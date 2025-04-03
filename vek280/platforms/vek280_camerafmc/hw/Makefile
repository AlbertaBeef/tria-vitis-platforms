# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

RM = rm -rf
VIVADO = $(XILINX_VIVADO)/bin/vivado
#JOBS ?= $(shell nproc)
#JOBS ?= 12
JOBS ?= 4

VIV_DESIGN = vek280_camerafmc

VIV_PRJ_DIR = project
VIV_SCRIPTS_DIR = scripts

VIV_XSA = $(VIV_PRJ_DIR)/$(VIV_DESIGN).xsa
VIV_SRC = $(VIV_SCRIPTS_DIR)/main.tcl

ISP_DIR= ip/isp_single
ISP_IP = isppipeline.prj

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make xsa'
	@echo '    Generate extensible xsa for platform generation'
	@echo ''

.PHONY: all
all: xsa

$(ISP_IP):
	#make -C $(ISP_DIR) ip XPART=xcve2802-vsvh1760-2MP-e-S-es1
	make -C $(ISP_DIR) ip XPART=xcve2802-vsvh1760-2MP-e-S

xsa: $(ISP_IP) $(VIV_XSA)

$(VIV_XSA): $(VIV_SRC)
	$(VIVADO) -mode batch -notrace -source $(VIV_SRC) -tclargs -jobs $(JOBS)
	#$(VIVADO) -mode gui -notrace -source $(VIV_SRC) -tclargs -jobs $(JOBS)

.PHONY: clean
clean:
	$(RM) $(VIV_PRJ_DIR) vivado* .Xil *dynamic* *.log *.xpe .crashReporter/
	make -C $(ISP_DIR) clean
