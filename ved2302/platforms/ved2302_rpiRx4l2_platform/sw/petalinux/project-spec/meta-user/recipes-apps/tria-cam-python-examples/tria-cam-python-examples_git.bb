DESCRIPTION = "Python based OpenCV examples for cameras"
HOMEPAGE = "https://github.com/AlbertaBeef/tria_cam_python_examples"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

SRC_URI = "git://github.com/AlbertaBeef/tria_cam_python_examples;protocol=https;branch=2023.2"
SRCREV = "${AUTOREV}"

RDEPENDS:${PN} = "python3 \
		  python3-numpy \
		  opencv \
		  bash \
		  gstmarkerdetect \
"

S = "${WORKDIR}/git"

do_install() {

	HOMEPATH="${D}/home/root/tria_cam_python_examples"
	install -d ${HOMEPATH}
	cp -r ${S}/tria_rpicam ${HOMEPATH}/tria_rpicam

	install -m 0755 ${S}/rpicam_cc_script.sh ${HOMEPATH}/rpicam_cc_script.sh
	install -m 0755 ${S}/rpicam_wb_script.sh ${HOMEPATH}/rpicam_wb_script.sh
	install -m 0755 ${S}/rpicam_aaswb.sh ${HOMEPATH}/rpicam_aaswb.sh

	install -m 0755 ${S}/tria_rpicam_passthrough.py ${HOMEPATH}/tria_rpicam_passthrough.py
	install -m 0755 ${S}/tria_rpicam_control.py ${HOMEPATH}/tria_rpicam_control.py
	install -m 0755 ${S}/tria_rpicam_aaswb.py ${HOMEPATH}/tria_rpicam_aaswb.py
}

FILES:${PN} = "/home/root/tria_cam_python_examples \
               /home/root/tria_cam_python_examples/tria_rpicam \
"

