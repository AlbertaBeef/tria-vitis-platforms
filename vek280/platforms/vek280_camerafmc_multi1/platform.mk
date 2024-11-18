#******************************************************************************
# Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#******************************************************************************
.EXPORT_ALL_VARIABLES:

#tools
VIVADO  = $(XILINX_VIVADO)/bin/vivado
DTC     = $(XILINX_VITIS)/bin/dtc
BOOTGEN = $(XILINX_VITIS)/bin/bootgen
XSCT    = $(XILINX_VITIS)/bin/xsct

#platform specific
#PLATFORM = xilinx_vek280_es1_trd
PLATFORM = tria_vek280_camerafmc
CPU_ARCH = a72
#BOARD    = versal-vek280-revb
BOARD    = versal-vek280
CORE     = psv_cortexa72_0

#versioning
#VERSION          ?= 202310_1
#VER              ?= 202310.1
VERSION          ?= 202320_1
VER              ?= 202320.1

#common
TOP_DIR         ?= $(shell readlink -f .)

#hw related
XSA_DIR         ?= $(TOP_DIR)/hw/project
XSA             ?= $(XSA_DIR)/vek280_trd.xsa
RP_XSA          ?= $(XSA_DIR)/rp/rp.xsa
STATIC_XSA      ?= $(XSA_DIR)/static.xsa
HW_EMU_XSA      ?= $(XSA_DIR)/hw_emu/hw_emu.xsa
PRE_SYNTH       ?= FALSE

#sw related
SW_DIR           = $(TOP_DIR)/sw/build
BOOT_DIR         = $(SW_DIR)/platform/boot
IMAGE_DIR        = $(SW_DIR)/platform/image
SW_FILES         = $(IMAGE_DIR)/boot.scr $(BOOT_DIR)/u-boot.elf $(BOOT_DIR)/bl31.elf

#platform related
PLATFORM_NAME    = $(PLATFORM)_$(VER)
PLATFORM_SW_SRC  = $(TOP_DIR)/platform
PLATFORM_DIR     = $(TOP_DIR)/platform_repo

#flow related
PREBUILT_LINUX_PATH ?= /opt/xilinx/platform/xilinx-versal-common-v2023.1
ifneq ($(wildcard $(TOP_DIR)/xilinx-versal-common-v2023.1),)
PREBUILT_LINUX_PATH ?= $(TOP_DIR)/xilinx-versal-common-v2023.1
endif
# Getting Absolute paths
ifneq ("$(wildcard $(XSA))","")
  XSA_ABS ?= $(realpath $(XSA))
  override XSA := $(realpath $(XSA_ABS))
endif
ifneq ("$(wildcard $(PREBUILT_LINUX_PATH_ABS))","")
  PREBUILT_LINUX_PATH_ABS ?= $(realpath $(PREBUILT_LINUX_PATH))
  override PREBUILT_LINUX_PATH := $(realpath $(PREBUILT_LINUX_PATH_ABS))
endif

#common targets
check-vitis:
ifeq ($(XILINX_VITIS),)
	$(error ERROR: 'XILINX_VITIS' variable not set, please set correctly and rerun)
endif

check-prebuilt:
ifeq (,$(wildcard $(PREBUILT_LINUX_PATH)))
	$(info )
	$(info PREBUILT common images cannot be found at $(PREBUILT_LINUX_PATH))
	$(info If PREBUILT common images are present in another directory, Please specify the path to images as follows :)
	$(info make all PREBUILT_LINUX_PATH=/path/to/boot_files/dir)
	$(info else)
	$(info Please download PREBUILT common images from https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-platforms.html and extract them to /opt/xilinx/platform)
	$(error )
else
	$(info Found Platform Images at $(PREBUILT_LINUX_PATH))
endif
ifeq ($(PREBUILT_LINUX_PATH),)
	$(error ERROR: 'PREBUILT_LINUX_PATH' is not accesible, please set this flag to path containing common software)
endif
