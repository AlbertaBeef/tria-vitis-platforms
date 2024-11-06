FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg"
SRC_URI += "file://vaitracing.cfg"
KERNEL_FEATURES:append = " bsp.cfg"
