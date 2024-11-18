FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
        file://0001-v4l-xilinx-dma-Fix-back-pressure-issue-in-multistrea.patch \
	file://0001-drm_atomic_helper-suppress-vblank-timed-out-warning-.patch \
	file://0002-drm_vblank-suppress-vblank-timed-out-warning-message.patch \
	file://0001-gpu-drm-hdmi-Disable-HDCP2X-and-FRL-mode.patch \
        file://0001-media-i2c-Update-imx219-driver-based-on-rpi-6-1-y.patch \
        file://0002-media-i2c-Update-dw9807-vcm-driver-based-on-rpi-6-1-y.patch \
        file://0003-media-i2c-Add-imx477-imx708-drivers-based-on-rpi-6-1-y.patch \
        file://0004-media-i2c-Add-imx500-driver-based-on-rpi-6-6-y.patch \
        file://0005-spi-Add-spi-rp2040-gpio-bridge-driver-based-on-rpi-6-6-y.patch \
        file://0006-media-v4l2-core-Add-v4l2-cci-driver-based-on-rpi-6-6-y.patch \
        file://0007-uapi-v4l2-controls-add-new-offset-for-imx500-based-on-rpi-6-6-y.patch \
        file://0008-media-i2c-Patch-imx500-driver-for-linux-kernel-6.1.patch \
"

KERNEL_FEATURES:append = " bsp.cfg"
SRC_URI += "file://user-2024-04-add-xilinx-drivers.cfg \
            file://user-2024-04-add-imx219-driver.cfg \
            file://user_2024-10-add-imx708-imx477-drivers.cfg \
            file://user_2024-11-add-imx500-drivers.cfg \
            "
