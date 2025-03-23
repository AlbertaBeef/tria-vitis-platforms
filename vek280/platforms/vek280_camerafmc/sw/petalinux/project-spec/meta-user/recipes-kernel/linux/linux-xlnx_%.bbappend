FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
        file://0001-v4l-xilinx-dma-Fix-back-pressure-issue-in-multistrea.patch \
	file://0001-drm_atomic_helper-suppress-vblank-timed-out-warning-.patch \
	file://0002-drm_vblank-suppress-vblank-timed-out-warning-message.patch \
	file://0001-gpu-drm-hdmi-Disable-HDCP2X-and-FRL-mode.patch \
   file://0001-Add-MEDIA_BUS_FMT_SENSOR_DATA-format-based-on-rpi-6.6.y.patch \
   file://0002-media-i2c-Update-imx219-driver-based-on-rpi-6.6.y.patch \
   file://0003-media-i2c-Add-imx708-driver-based-on-rpi-6.6.y.patch \
   file://0004-media-i2c-Update-dw9807-vcm-driver-based-on-rpi-6.6.y.patch \
   file://0005-media-i2c-Add-imx477-driver-based-on-rpi-6.6.y.patch \
   file://0006-media-i2c-Add-imx500-driver-based-on-rpi-6.6.y.patch \
   file://0007-spi-Add-spi-rp2040-gpio-bridge-driver-based-on-rpi-6.6.y.patch \
"

KERNEL_FEATURES:append = " bsp.cfg"

