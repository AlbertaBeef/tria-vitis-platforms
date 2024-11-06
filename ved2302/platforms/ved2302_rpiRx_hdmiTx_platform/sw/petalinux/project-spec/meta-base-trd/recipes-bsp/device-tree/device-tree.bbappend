FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	file://system-user.dtsi \
	file://i2c0_mux_conf.dtsi \
        file://0001-mipi_csi2_rx-Use-isppipeline_in-as-remote-endpoint.patch \
        file://0002-common_proc.tcl-Add-support-when-axis_broad-NM-conne.patch \
        file://0003-ispipeline.tcl-Add-axis_broadcaster-IP-support.patch"


require ${@'device-tree-sdt.inc' if d.getVar('SYSTEM_DTFILE') != '' else ''}
