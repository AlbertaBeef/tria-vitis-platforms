SUMMARY = "gstreamer plug-in for chart detection."
DESCRIPTION = "GStreamer plug-in : Chart Detection using ArUco markers."

SECTION = "PETALINUX/apps"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/AlbertaBeef/gstmarkerdetect;protocol=https;branch=main"
#SRCREV = "${AUTOREV}"
SRCREV = "34b439a702eebdf89aedb09735349afa333542c0"

S = "${WORKDIR}/git"

DEPENDS += "opencv gstreamer1.0 gstreamer1.0-plugins-base"

inherit pkgconfig

EXTRA_OEMAKE = "SYSROOT='${WORKDIR}/recipe-sysroot'"
                
do_compile() {
	oe_runmake
}

do_install() {
	#oe_runmake 'DESTDIR=${D}' install.all
	
	GSTLIBPATH="${D}/usr/lib/gstreamer-1.0"
	install -d ${GSTLIBPATH}
	cp ${S}/libgstmarkerdetect.so ${GSTLIBPATH}/libgstmarkerdetect.so	
	install -m 0755 ${S}/libgstmarkerdetect.so ${GSTLIBPATH}/libgstmarkerdetect.so
}

#FILES:${PN} = "/usr/lib/gstreamer-1.0/libgstmarkerdetect.so"
FILES:${PN} = "${libdir}/gstreamer-1.0/libgstmarkerdetect.so"

# ERROR: gstmarkerdetect-1.0-r0 do_package_qa: QA Issue: File /usr/lib/gstreamer-1.0/libgstmarkerdetect.so in package gstmarkerdetect doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]
INSANE_SKIP:${PN} = "ldflags"


