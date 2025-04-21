# (C) Copyright 2025 Tria Technologies, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

CWD = $(shell readlink -f .)
TOP_DIR = $(CWD)/../../
RM = rm -rf

SYSTEM_XSA = $(CWD)/project-spec/hw-description/system.xsa
PETA_FILES += $(CWD)/images/linux/boot.scr
PETA_FILES += $(CWD)/images/linux/bl31.elf
PETA_FILES += $(CWD)/images/linux/u-boot.elf
PETA_FILES += $(CWD)/images/linux/system.dtb
PETA_FILES += $(CWD)/images/linux/Image
PETA_FILES += $(CWD)/images/linux/rootfs.ext4
BOOT_IMAGE = $(CWD)/images/linux/BOOT.BIN
WIC_IMAGE  = $(CWD)/images/linux/petalinux-sdimage.wic.gz

XSA_DIR    = $(CWD)/../../hw/project
SW_DIR     ?= $(CWD)/../../sw/build
BOOT_DIR   ?= $(SW_DIR)/platform/boot
IMAGE_DIR  ?= $(SW_DIR)/platform/image
ROOTFS_DIR ?= $(SW_DIR)/platform/filesystem

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make all'
	@echo '    This rule builds all'
	@echo ''
	@echo '  make wic'
	@echo '    This rule builds an SD card wic image.'
	@echo ''
	@echo '  make boot'
	@echo '    This rule builds a boot image (BOOT.BIN).'
	@echo ''
	@echo '  make linux XSA=<xsa/dir> '
	@echo '    This rule builds a full Linux image. It is always executed'
	@echo '    unconditionally. The yocto build system tracks changes and'
	@echo '    performs an incremental build on subsequent runs.'
	@echo '    Defalue XSA location: ${XSA}'
	@echo ''
	@echo '  make sdk'
	@echo '    This rule builds an SDK.'
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
	petalinux-config --get-hw-description $(XSA_DIR) --silentconfig

.PHONY: linux
linux: $(SYSTEM_XSA) $(PETA_FILES)
$(PETA_FILES): $(SYSTEM_XSA) 
	petalinux-config -c kernel --silentconfig
	petalinux-config -c rootfs --silentconfig
	petalinux-build

xrt: $(SYSTEM_XSA)
	petalinux-config -c xrt --silentconfig

zocl: $(SYSTEM_XSA)
	petalinux-config -c zocl --silentconfig

.PHONY: sdk
sdk:  $(SYSTEM_XSA)
	petalinux-build --sdk

.PHONY: spfm
spfm:  $(SW_FILES)
$(SW_FILES): $(SYSTEM_XSA) $(PETA_FILES)
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
all:  linux spfm boot wic

.PHONY: boot
boot: $(BOOT_IMAGE)
$(BOOT_IMAGE):
	$(info "BOOT image for platforms")
	@if [ -f project-spec/hw-description/*.pdi ]; then  \
		echo "INFO: BOOT image generation started...";  \
		petalinux-package boot --force --u-boot --qemu-rootfs no --bif ./package_scripts/bootgen.bif;  \
	else  \
		echo "WARNING: "hw.bit" file not found. Skipping BOOT image generation.";  \
	fi

.PHONY: wic
#wic: $(BOOT_IMAGE) $(PETA_FILES)
#wic: $(WIC_IMAGE)
#$(WIC_IMAGE):
wic:
	petalinux-package wic -w ./package_scripts/sdimage.wks --extra-bootfiles=" system.dtb " --wic-extra-args="-c gzip"
		
clean:
	petalinux-build -x mrproper
	-@$(RM) project-spec/hw-description/*.xsa project-spec/hw-description/*.pdi
