FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
        file://0001-media-i2c-Add-max9296-and-ox03f10-in-Makefile.patch \
        file://0002-media-i2c-add-max9296-and-ox03f10-in-Kconfig.patch \
        file://0003-media-i2c-v4l2-driver-for-MAX9296-multiinstance-desr.patch \
        file://0004-media-i2c-i2c-client-driver-for-ox03f10-sensor-and-M.patch \
	file://0005-fix-Runtime-PM-usage-count-underflow.patch \
        file://0001-v4l-xilinx-dma-Fix-back-pressure-issue-in-multistrea.patch \
	file://0001-drm_atomic_helper-suppress-vblank-timed-out-warning-.patch \
	file://0002-drm_vblank-suppress-vblank-timed-out-warning-message.patch \
	file://0001-gpu-drm-hdmi-Disable-HDCP2X-and-FRL-mode.patch \
"
KERNEL_FEATURES:append = " bsp.cfg"
SRC_URI += "file://user_2023-07-14-06-32-00.cfg \
            file://user_2023-07-20-09-05-00.cfg \
            "
