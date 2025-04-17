# (C) Copyright 2025 Tria Technologies, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

.PHONY: all linux clean

include ../platform.mk

all linux:
	$(info patch sw/Makefile for sw/petalinux building)
	$(MAKE) -C petalinux all

clean:
	$(RM) -r build
	$(MAKE) -C petalinux clean
