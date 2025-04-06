FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
        file://0001-v4l-xilinx-dma-Fix-back-pressure-issue-in-multistrea.patch \
	file://0001-drm_atomic_helper-suppress-vblank-timed-out-warning-.patch \
	file://0002-drm_vblank-suppress-vblank-timed-out-warning-message.patch \
	file://0001-gpu-drm-hdmi-Disable-HDCP2X-and-FRL-mode.patch \
"

KERNEL_FEATURES:append = " bsp.cfg"
SRC_URI += "file://user-2024-04-add-xilinx-drivers.cfg \
            file://user-2024-04-add-imx219-driver.cfg \
            "
