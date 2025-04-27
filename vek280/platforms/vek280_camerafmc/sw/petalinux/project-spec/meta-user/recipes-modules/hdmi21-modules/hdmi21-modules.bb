SUMMARY = "Recipe for  build an external hdmi21-modules Linux kernel module"
SECTION = "PETALINUX/modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

INHIBIT_PACKAGE_STRIP = "1"

SRC_URI = "file://Makefile \
	   file://xfmc/fmc64.c \
	   file://xfmc/fmc65.c \
	   file://xfmc/fmc74.c \
	   file://xfmc/fmc.c \
	   file://xfmc/idt.c \
	   file://xfmc/Makefile \
	   file://xfmc/tipower.c \
	   file://xfmc/ti_tmds1204_tx.c \
	   file://xfmc/ti_tmds1204_rx.c \
	   file://xfmc/x_vfmc.c \
	   file://xfmc/si5344.c \
	   file://COPYING \
          "
S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.
