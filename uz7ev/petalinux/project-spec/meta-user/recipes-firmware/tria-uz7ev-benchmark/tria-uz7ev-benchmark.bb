#
# This file is the tria-uz7ev-benchmark recipe.
#

SUMMARY = "Simple tria-uz7ev-benchmark to use dfx_user_dts class"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_user_dts

COMPATIBLE_MACHINE:zynqmp = ".*"

SRC_URI = "file://tria_uz7ev_benchmark.bit \
           file://tria_uz7ev_benchmark.xclbin \
           file://tria_uz7ev_benchmark.dtsi \
           file://shell.json \
           "
