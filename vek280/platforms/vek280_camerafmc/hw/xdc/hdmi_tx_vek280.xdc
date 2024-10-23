# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0


# GT Pins
set_property PACKAGE_PIN P41 [get_ports {GT_Serial_grx_p[0]}]
set_property PACKAGE_PIN R38 [get_ports {GT_Serial_gtx_p[0]}]
set_property PACKAGE_PIN M41 [get_ports {GT_Serial_grx_p[1]}]
set_property PACKAGE_PIN P36 [get_ports {GT_Serial_gtx_p[1]}]
set_property PACKAGE_PIN L39 [get_ports {GT_Serial_grx_p[2]}]
set_property PACKAGE_PIN N38 [get_ports {GT_Serial_gtx_p[2]}]
set_property PACKAGE_PIN K41 [get_ports {GT_Serial_grx_p[3]}]
set_property PACKAGE_PIN M36 [get_ports {GT_Serial_gtx_p[3]}]

# HDMI RX
#FMCP1_GBTCLK0_M2C_C_P
set_property PACKAGE_PIN AC32 [get_ports {HDMI_RX_CLK_P_IN_V_clk_p[0]}]
create_clock -period 3.367 [get_ports HDMI_RX_CLK_P_IN_V_clk_p]
#SI570_8A34001_MUX_BUF0_C_P
set_property PACKAGE_PIN Y30 [get_ports {GT_DRU_FRL_CLK_IN_clk_p[0]}]
create_clock -period 2.500 [get_ports GT_DRU_FRL_CLK_IN_clk_p]

#FMCP1_LA08_P
set_property PACKAGE_PIN AP10 [get_ports RX_REFCLK_P_OUT]
set_property IOSTANDARD LVDS15 [get_ports RX_REFCLK_P_OUT]

#FMCP1_LA29_N
#set_property PACKAGE_PIN AW15 [get_ports RX_DET_N_IN]
#set_property IOSTANDARD LVCMOS15 [get_ports RX_DET_N_IN]

# HDMI TX
#FMCP1_GBTCLK1_M2C_C_P
set_property PACKAGE_PIN AB30 [get_ports {TX_REFCLK_P_IN_V_clk_p[0]}]
create_clock -period 3.367 [get_ports TX_REFCLK_P_IN_V_clk_p]

#FMCP1_LA13_P
set_property PACKAGE_PIN AN16 [get_ports TX_HPD_IN]
set_property IOSTANDARD LVCMOS15 [get_ports TX_HPD_IN]

#FMCP1_LA03_N
set_property PACKAGE_PIN AN15 [get_ports TX_DDC_OUT_scl_io]
set_property IOSTANDARD LVCMOS15 [get_ports TX_DDC_OUT_scl_io]
#FMCP1_LA03_P
set_property PACKAGE_PIN AP15 [get_ports TX_DDC_OUT_sda_io]
set_property IOSTANDARD LVCMOS15 [get_ports TX_DDC_OUT_sda_io]

# Misc
#GPIO_LED_0_LS
set_property PACKAGE_PIN AT12 [get_ports LED0]
set_property IOSTANDARD LVCMOS15 [get_ports LED0]


#FMCP1_LA23_N
set_property PACKAGE_PIN AP14 [get_ports IDT8T49N241_LOL_IN]
set_property IOSTANDARD LVCMOS15 [get_ports IDT8T49N241_LOL_IN]

set_property PACKAGE_PIN AT17 [get_ports {rx_en[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {rx_en[0]}]

set_property PACKAGE_PIN AM16 [get_ports {tx_en[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {tx_en[0]}]

set_property IOSTANDARD DIFF_SSTL15 [get_ports {lpddr4_clk1_clk_p}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {lpddr4_clk2_clk_p}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {lpddr4_clk3_clk_p}]

set_property IOSTANDARD LVCMOS15 [get_ports {ch1_lpddr4_trip1_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ch0_lpddr4_trip1_reset_n}]
set_property IOSTANDARD LVCMOS12 [get_ports {ch1_lpddr4_trip2_reset_n}]
set_property IOSTANDARD LVCMOS12 [get_ports {ch0_lpddr4_trip2_reset_n}]
set_property IOSTANDARD LVCMOS12 [get_ports {ch1_lpddr4_trip3_reset_n}]
set_property IOSTANDARD LVCMOS12 [get_ports {ch0_lpddr4_trip3_reset_n}]

set_property PACKAGE_PIN AT16 [get_ports HDMI_CTRL_sda_io]
set_property PACKAGE_PIN AR15 [get_ports HDMI_CTRL_scl_io]
set_property IOSTANDARD LVCMOS15 [get_ports HDMI_CTRL_scl_io]
set_property IOSTANDARD LVCMOS15 [get_ports HDMI_CTRL_sda_io]

#########
## End ##
#########