#
# This file is the tria-zub1cg-base recipe.
#

SUMMARY = "Simple tria-zub1cg-base to use dfx_user_dts class"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_user_dts

COMPATIBLE_MACHINE:zynqmp = ".*"

SRC_URI = "file://tria_zub1cg_base.bit \
           file://tria_zub1cg_base.dtsi \
           file://shell.json \
           "
