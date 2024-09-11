#
# This file is the tria-u96v2-dualcam-dpu recipe.
#

SUMMARY = "Simple tria-u96v2-dualcam-dpu to use dfx_user_dts class"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_user_dts

COMPATIBLE_MACHINE:zynqmp = ".*"

SRC_URI = "file://tria_u96v2_dualcam_dpu.bit \
           file://tria_u96v2_dualcam_dpu.xclbin \
           file://tria_u96v2_dualcam_dpu.dtsi \
           file://shell.json \
           "
