#
# This file is the initcams recipe.
#

SUMMARY = "Scripts for RPi Camera FMC"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://init_cams_yuyv.sh \
	   file://init_cams_bgr.sh \
	   file://displaycams_bgr.sh \
	   file://displaycams_remote.sh \
	   file://capture_frames_yavta_yuyv.sh \
	   file://capture_frames_yavta_bgr.sh \
	   file://capture_frames_libcamera_bgr.sh \
"

S = "${WORKDIR}"

RDEPENDS:${PN} += "bash"

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ${WORKDIR}/init_cams_yuyv.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/init_cams_bgr.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/displaycams_bgr.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/displaycams_remote.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/capture_frames_yavta_yuyv.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/capture_frames_yavta_bgr.sh ${D}${bindir}/
        install -m 0755 ${WORKDIR}/capture_frames_libcamera_bgr.sh ${D}${bindir}/
}
