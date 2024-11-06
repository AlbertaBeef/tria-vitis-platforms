# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

RM = rm -rf
HLS = vitis_hls
CLKP ?= 3.3333
XPART ?= xczu7ev-fbvb900-1-i


.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make ip'
	@echo '    Generate IP for Single Sensor ISP'
	@echo ''

.PHONY: all
all: ip

ip:
	@echo 'set CLKP $(CLKP)' >> ./settings.tcl
	@echo 'set XPART $(XPART)' >> ./settings.tcl
	$(HLS) -f run_hls_isp.tcl

.PHONY: clean
clean:
	$(RM) settings.tcl *.prj *.log .crashReporter/

