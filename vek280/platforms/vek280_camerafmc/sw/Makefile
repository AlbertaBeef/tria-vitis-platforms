#******************************************************************************
# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
# Copyright (C) 2022-2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: MIT
#******************************************************************************

include ../platform.mk

CWD = $(shell readlink -f .)
RM = rm -rf

SYSTEM_XSA = $(CWD)/petalinux/project-spec/hw-description/system.xsa
PETA_FILES += $(CWD)/petalinux/images/linux/boot.scr
PETA_FILES += $(CWD)/petalinux/images/linux/bl31.elf
PETA_FILES += $(CWD)/petalinux/images/linux/u-boot.elf
PETA_FILES += $(CWD)/petalinux/images/linux/system.dtb
PETA_FILES += $(CWD)/petalinux/images/linux/Image
PETA_FILES += $(CWD)/petalinux/images/linux/rootfs.ext4

XSA_DIR    = $(CWD)/../hw/project
SW_DIR     = $(CWD)/build
BOOT_DIR   = $(SW_DIR)/platform/boot
IMAGE_DIR  = $(SW_DIR)/platform/image
ROOTFS_DIR = $(SW_DIR)/platform/filesystem

.ONESHELL:

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make linux XSA=<xsa/dir> '
	@echo '    This rule builds a full Linux image. It is always executed'
	@echo '    unconditionally. The yocto build system tracks changes and'
	@echo '    performs an incremental build on subsequent runs.'
	@echo '    Defalue XSA location: ${XSA}'
	@echo ''
	@echo '  make spfm'
	@echo '    This rule will export platform needed boot files for further'
	@echo '    pl intergration.'
	@echo ''
	@echo '  make clean'
	@echo '    This rule clean files generated while building'
	@echo ''



.PHONY: config
config: $(SYSTEM_XSA)
$(SYSTEM_XSA):
	@if [ -d petalinux ]; then  \
                echo "Configuring Project"; \
		cd petalinux; \
		petalinux-config --get-hw-description $(XSA_DIR) --silentconfig; \
        else  \
                echo "Creating new Project"; \
                petalinux-create -t project -s vek280_trd.bsp -n petalinux; \
		cd petalinux; \
		petalinux-config --get-hw-description $(XSA_DIR) --silentconfig; \
        fi

.PHONY: linux
linux: $(SYSTEM_XSA) $(PETA_FILES)
$(PETA_FILES): $(SYSTEM_XSA) 
	cd petalinux
	petalinux-build

.PHONY: spfm
spfm:  $(SW_FILES)
$(SW_FILES): $(SYSTEM_XSA) $(PETA_FILES)
	@cd petalinux
	@mkdir -p $(BOOT_DIR) $(IMAGE_DIR) $(ROOTFS_DIR)
	@cp -f images/linux/boot.scr   $(IMAGE_DIR)/boot.scr
	@cp -f images/linux/system.dtb $(IMAGE_DIR)/system.dtb
	@cp -f images/linux/Image      $(IMAGE_DIR)/Image
	@cp -f images/linux/bl31.elf   $(BOOT_DIR)/bl31.elf
	@cp -f images/linux/system.dtb ${BOOT_DIR}/system.dtb
	@cp -f images/linux/u-boot.elf $(BOOT_DIR)/u-boot.elf
	@cp -f images/linux/rootfs.tar.gz $(ROOTFS_DIR)/rootfs.tar.gz
	@cp -f images/linux/rootfs.ext4   $(ROOTFS_DIR)/rootfs.ext4

.PHONY: all
all:  linux spfm

clean:
	cd petalinux
	petalinux-build -x mrproper
	-@$(RM) project-spec/hw-description/*.xsa project-spec/hw-description/*.pdi
