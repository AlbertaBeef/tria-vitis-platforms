FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg \
        file://0001-v4l-xilinx-dma-Fix-back-pressure-issue-in-multistrea.patch \
	file://0001-gpu-drm-hdmi-Force-driver-to-run-only-in-TMDS-mode.patch \
	file://0001-drm_atomic_helper-suppress-vblank-timed-out-warning-.patch \
	file://0002-drm_vblank-suppress-vblank-timed-out-warning-message.patch \
"
SRC_URI += "file://user_2024-04-12-21-19-00.cfg \
            file://vaitracing.cfg"
KERNEL_FEATURES:append = " bsp.cfg"
