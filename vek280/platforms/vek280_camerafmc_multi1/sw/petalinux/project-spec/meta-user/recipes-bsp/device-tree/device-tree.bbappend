FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DT_INCLUDE:append = " ${TMPDIR}/work-shared/xilinx-vek280/kernel-source/include/"

SRC_URI:append = " file://system-user.dtsi \
                file://i2c0_mux_conf.dtsi \
                file://pl-custom.dtsi \
                file://display.dtsi \
                file://mipi-0-imx219.dtsi \
                file://mipi-1-imx219.dtsi \
                file://mipi-1-imx708.dtsi \
                file://mipi-3-imx219.dtsi \
                file://mipi-3-imx477.dtsi \
                file://mipi-3-imx500.dtsi \
                "

require ${@'device-tree-sdt.inc' if d.getVar('SYSTEM_DTFILE') != '' else ''}
