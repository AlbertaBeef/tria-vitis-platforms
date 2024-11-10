#******************************************************************************
# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
# Copyright (C) 2022-2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: MIT
#******************************************************************************

.PHONY: all linux clean

include ../platform.mk

all linux:
	$(info patch sw/Makefile for sw/petalinux building)
	$(MAKE) -C petalinux all

clean:
	$(RM) -r build
	$(MAKE) -C petalinux clean
