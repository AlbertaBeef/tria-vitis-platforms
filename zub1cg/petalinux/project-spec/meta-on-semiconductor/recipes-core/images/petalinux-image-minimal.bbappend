DESCRIPTION = "Image definition for zuboard & ultra96v2 dual cameras boards"
LICENSE = "MIT"

DUALCAM_PACKAGES += "\
		ap1302 \
		libdrm \
		libdrm-tests \
"

IMAGE_INSTALL:append:u96v2-sbc-dualcam = " \
		${DUALCAM_PACKAGES} \
"

IMAGE_INSTALL:append:zub1cg-sbc-dualcam = " \
		${DUALCAM_PACKAGES} \
"
