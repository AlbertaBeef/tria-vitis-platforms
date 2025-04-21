# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0


#################################################################
#################### Stack FMC (Opsero) #########################
#################################################################

#----------------------------------------------------------------------------------------
# Constraints for Opsero FPGA Drive FMC Gen4 ref design for VEK280 using 2x SSDs
#----------------------------------------------------------------------------------------

# SSD1 PCI Express reset (perst_0)
#set_property PACKAGE_PIN AV30 [get_ports {pcie_rst_0[0]}]; # LA00_CC_P
#set_property IOSTANDARD LVCMOS15 [get_ports {pcie_rst_0[0]}]

# SSD2 PCI Express reset (perst_1)
#set_property PACKAGE_PIN BA31 [get_ports {pcie_rst_1[0]}]; # LA04_P
#set_property IOSTANDARD LVCMOS15 [get_ports {pcie_rst_1[0]}]

# SSD1 PE Detect (pedet_0, not connected in the design)
# set_property PACKAGE_PIN AW30 [get_ports {pcie_det_0[0]}]; # LA00_CC_N
# set_property IOSTANDARD LVCMOS15 [get_ports {pcie_det_0[0]}]

# SSD2 PE Detect (pedet_1, not connected in the design)
# set_property PACKAGE_PIN BB31 [get_ports {pcie_det_1[0]}]; # LA04_N
# set_property IOSTANDARD LVCMOS15 [get_ports {pcie_det_1[0]}]

# Disable signal for 3.3V power supply for SSD2 (disable_ssd2_pwr)
#set_property PACKAGE_PIN AW32 [get_ports disable_ssd2_pwr]; # LA07_P
#set_property IOSTANDARD LVCMOS15 [get_ports disable_ssd2_pwr]

##############################
# PCIe reference clock 100MHz
##############################

# SSD1 ref clock
set_property PACKAGE_PIN W32 [get_ports {pcie_ref_clk_0_clk_p[0]}]; # GBTCLK0_M2C_P
set_property PACKAGE_PIN W33 [get_ports {pcie_ref_clk_0_clk_n[0]}]; # GBTCLK0_M2C_N
create_clock -period 10.000 -name pcie_ref_clk_0_clk_p -waveform {0.000 5.000} [get_ports pcie_ref_clk_0_clk_p]

# SSD2 ref clock
set_property PACKAGE_PIN N34 [get_ports {pcie_ref_clk_1_clk_p[0]}]; # GBTCLK1_M2C_P
set_property PACKAGE_PIN N35 [get_ports {pcie_ref_clk_1_clk_n[0]}]; # GBTCLK1_M2C_N
create_clock -period 10.000 -name pcie_ref_clk_1_clk_p -waveform {0.000 5.000} [get_ports pcie_ref_clk_1_clk_p]

############################
# SSD1 Gigabit transceivers
############################

set_property PACKAGE_PIN K36 [get_ports {pcie_0_gtx_p[0]}]; # DP0_C2M_P
set_property PACKAGE_PIN K37 [get_ports {pcie_0_gtx_n[0]}]; # DP0_C2M_N
set_property PACKAGE_PIN J39 [get_ports {pcie_0_grx_p[0]}]; # DP0_M2C_P
set_property PACKAGE_PIN J40 [get_ports {pcie_0_grx_n[0]}]; # DP0_M2C_N

set_property PACKAGE_PIN H36 [get_ports {pcie_0_gtx_p[1]}]; # DP1_C2M_P
set_property PACKAGE_PIN H37 [get_ports {pcie_0_gtx_n[1]}]; # DP1_C2M_N
set_property PACKAGE_PIN H41 [get_ports {pcie_0_grx_p[1]}]; # DP1_M2C_P
set_property PACKAGE_PIN H42 [get_ports {pcie_0_grx_n[1]}]; # DP1_M2C_N

set_property PACKAGE_PIN F36 [get_ports {pcie_0_gtx_p[2]}]; # DP2_C2M_P
set_property PACKAGE_PIN F37 [get_ports {pcie_0_gtx_n[2]}]; # DP2_C2M_N
set_property PACKAGE_PIN G39 [get_ports {pcie_0_grx_p[2]}]; # DP2_M2C_P
set_property PACKAGE_PIN G40 [get_ports {pcie_0_grx_n[2]}]; # DP2_M2C_N

set_property PACKAGE_PIN E34 [get_ports {pcie_0_gtx_p[3]}]; # DP3_C2M_P
set_property PACKAGE_PIN E35 [get_ports {pcie_0_gtx_n[3]}]; # DP3_C2M_N
set_property PACKAGE_PIN F41 [get_ports {pcie_0_grx_p[3]}]; # DP3_M2C_P
set_property PACKAGE_PIN F42 [get_ports {pcie_0_grx_n[3]}]; # DP3_M2C_N

############################
# SSD2 Gigabit transceivers
############################

set_property PACKAGE_PIN D36 [get_ports {pcie_1_gtx_p[0]}]; # DP4_C2M_P
set_property PACKAGE_PIN D37 [get_ports {pcie_1_gtx_n[0]}]; # DP4_C2M_N
set_property PACKAGE_PIN E39 [get_ports {pcie_1_grx_p[0]}]; # DP4_M2C_P
set_property PACKAGE_PIN E40 [get_ports {pcie_1_grx_n[0]}]; # DP4_M2C_N

set_property PACKAGE_PIN C34 [get_ports {pcie_1_gtx_p[1]}]; # DP5_C2M_P
set_property PACKAGE_PIN C35 [get_ports {pcie_1_gtx_n[1]}]; # DP5_C2M_N
set_property PACKAGE_PIN D41 [get_ports {pcie_1_grx_p[1]}]; # DP5_M2C_P
set_property PACKAGE_PIN D42 [get_ports {pcie_1_grx_n[1]}]; # DP5_M2C_N

set_property PACKAGE_PIN B36 [get_ports {pcie_1_gtx_p[2]}]; # DP6_C2M_P
set_property PACKAGE_PIN B37 [get_ports {pcie_1_gtx_n[2]}]; # DP6_C2M_N
set_property PACKAGE_PIN C39 [get_ports {pcie_1_grx_p[2]}]; # DP6_M2C_P
set_property PACKAGE_PIN C40 [get_ports {pcie_1_grx_n[2]}]; # DP6_M2C_N

set_property PACKAGE_PIN A34 [get_ports {pcie_1_gtx_p[3]}]; # DP7_C2M_P
set_property PACKAGE_PIN A35 [get_ports {pcie_1_gtx_n[3]}]; # DP7_C2M_N
set_property PACKAGE_PIN A39 [get_ports {pcie_1_grx_p[3]}]; # DP7_M2C_P
set_property PACKAGE_PIN A40 [get_ports {pcie_1_grx_n[3]}]; # DP7_M2C_N


#################################################################
################### Camera FMC (Opsero) #########################
#################################################################

# Requirements:
#    CAM1_CLK_SEL = 0 (clock is LA01)
#    CAM3_CLK_SEL = 1 (clock is LA31)
#    clk_sel[1:0] == 0b10 ??

# CAM1 and CAM3 CLK_SEL signals
set_property PACKAGE_PIN AW42 [get_ports {clk_sel[0]}]; # LA25_N
set_property IOSTANDARD LVCMOS12 [get_ports {clk_sel[0]}]

set_property PACKAGE_PIN AV42 [get_ports {clk_sel[1]}]; # LA25_P
set_property IOSTANDARD LVCMOS12 [get_ports {clk_sel[1]}]




# I2C signals for MIPI 0
set_property PACKAGE_PIN AY31 [get_ports mipi_0_rpi_iic_scl_io]; # LA03_N
set_property PACKAGE_PIN AY30 [get_ports mipi_0_rpi_iic_sda_io]; # LA03_P
set_property IOSTANDARD LVCMOS12 [get_ports mipi_0_rpi_iic_*]
set_property SLEW SLOW [get_ports mipi_0_rpi_iic_*]
set_property DRIVE 4 [get_ports mipi_0_rpi_iic_*]

# I2C signals for MIPI 1
set_property PACKAGE_PIN BA32 [get_ports mipi_1_rpi_iic_scl_io]; # LA05_N
set_property PACKAGE_PIN AY32 [get_ports mipi_1_rpi_iic_sda_io]; # LA05_P
set_property IOSTANDARD LVCMOS12 [get_ports mipi_1_rpi_iic_*]
set_property SLEW SLOW [get_ports mipi_1_rpi_iic_*]
set_property DRIVE 4 [get_ports mipi_1_rpi_iic_*]

# I2C signals for MIPI 2
#set_property PACKAGE_PIN AT38 [get_ports mipi_2_rpi_iic_scl_io]; # LA30_N
#set_property PACKAGE_PIN AR39 [get_ports mipi_2_rpi_iic_sda_io]; # LA30_P
#set_property IOSTANDARD LVCMOS12 [get_ports mipi_2_rpi_iic_*]
#set_property SLEW SLOW [get_ports mipi_2_rpi_iic_*]
#set_property DRIVE 4 [get_ports mipi_2_rpi_iic_*]

# I2C signals for MIPI 3
set_property PACKAGE_PIN AT41 [get_ports mipi_3_rpi_iic_scl_io]; # LA32_N
set_property PACKAGE_PIN AR41 [get_ports mipi_3_rpi_iic_sda_io]; # LA32_P
set_property IOSTANDARD LVCMOS12 [get_ports mipi_3_rpi_iic_*]
set_property SLEW SLOW [get_ports mipi_3_rpi_iic_*]
set_property DRIVE 4 [get_ports mipi_3_rpi_iic_*]

# GPIOs for MIPI camera 0
set_property PACKAGE_PIN AR32 [get_ports {mipi_0_rpi_gpio_tri_o[0]}]; # LA12_N
set_property PACKAGE_PIN AP32 [get_ports {mipi_0_rpi_gpio_tri_o[1]}]; # LA12_P
set_property IOSTANDARD LVCMOS12 [get_ports {mipi_0_rpi_gpio_tri_o[*]}]

# GPIOs for MIPI camera 1
set_property PACKAGE_PIN AW35 [get_ports {mipi_1_rpi_gpio_tri_o[0]}]; # LA09_N
set_property PACKAGE_PIN AV35 [get_ports {mipi_1_rpi_gpio_tri_o[1]}]; # LA09_P
set_property IOSTANDARD LVCMOS12 [get_ports {mipi_1_rpi_gpio_tri_o[*]}]

# GPIOs for MIPI camera 2
#set_property PACKAGE_PIN BB40 [get_ports {mipi_2_rpi_gpio_tri_o[0]}]; # LA19_N
#set_property PACKAGE_PIN BA41 [get_ports {mipi_2_rpi_gpio_tri_o[1]}]; # LA19_P
#set_property IOSTANDARD LVCMOS12 [get_ports {mipi_2_rpi_gpio_tri_o[*]}]

# GPIOs for MIPI camera 3
set_property PACKAGE_PIN BA39 [get_ports {mipi_3_rpi_gpio_tri_o[0]}]; # LA20_N
set_property PACKAGE_PIN AY39 [get_ports {mipi_3_rpi_gpio_tri_o[1]}]; # LA20_P
set_property IOSTANDARD LVCMOS12 [get_ports {mipi_3_rpi_gpio_tri_o[*]}]

# Reserved GPIOs
#set_property PACKAGE_PIN BA31 [get_ports {rsvd_gpio_tri_o[0]}]; # LA04_P
#set_property PACKAGE_PIN BB31 [get_ports {rsvd_gpio_tri_o[1]}]; # LA04_N
#set_property PACKAGE_PIN AW32 [get_ports {rsvd_gpio_tri_o[2]}]; # LA07_P
#set_property PACKAGE_PIN AW33 [get_ports {rsvd_gpio_tri_o[3]}]; # LA07_N
#set_property PACKAGE_PIN AR34 [get_ports {rsvd_gpio_tri_o[4]}]; # LA13_P
#set_property PACKAGE_PIN AT34 [get_ports {rsvd_gpio_tri_o[5]}]; # LA13_N
#set_property PACKAGE_PIN AY41 [get_ports {rsvd_gpio_tri_o[6]}]; # LA27_P
#set_property PACKAGE_PIN AY42 [get_ports {rsvd_gpio_tri_o[7]}]; # LA27_N
#set_property PACKAGE_PIN AR37 [get_ports {rsvd_gpio_tri_o[8]}]; # LA29_P
#set_property PACKAGE_PIN AT37 [get_ports {rsvd_gpio_tri_o[9]}]; # LA29_N
#set_property IOSTANDARD LVCMOS12 [get_ports {rsvd_gpio_tri_o[*]}]

# MIPI interface 0
set_property PACKAGE_PIN AV30 [get_ports {mipi_phy_if_0_clk_p}]; # LA00_CC_P
set_property PACKAGE_PIN AW30 [get_ports {mipi_phy_if_0_clk_n}]; # LA00_CC_N
set_property PACKAGE_PIN BA33 [get_ports {mipi_phy_if_0_data_p[0]}]; # LA06_P
set_property PACKAGE_PIN BB33 [get_ports {mipi_phy_if_0_data_n[0]}]; # LA06_N
set_property PACKAGE_PIN BB29 [get_ports {mipi_phy_if_0_data_p[1]}]; # LA02_P
set_property PACKAGE_PIN BB30 [get_ports {mipi_phy_if_0_data_n[1]}]; # LA02_N

#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_0_clk_p]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_0_clk_n]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_0_data_p[*]]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_0_data_n[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_p[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_0_data_n[*]]

set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_0_clk_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_0_clk_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_0_data_p[*]]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_0_data_n[*]]

# MIPI interface 1
set_property PACKAGE_PIN AU35 [get_ports {mipi_phy_if_1_clk_p}]; # LA01_CC_P
set_property PACKAGE_PIN AU36 [get_ports {mipi_phy_if_1_clk_n}]; # LA01_CC_N
set_property PACKAGE_PIN AT32 [get_ports {mipi_phy_if_1_data_p[0]}]; # LA15_P
set_property PACKAGE_PIN AU31 [get_ports {mipi_phy_if_1_data_n[0]}]; # LA15_N
set_property PACKAGE_PIN AR36 [get_ports {mipi_phy_if_1_data_p[1]}]; # LA14_P
set_property PACKAGE_PIN AT36 [get_ports {mipi_phy_if_1_data_n[1]}]; # LA14_N

#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_1_clk_p]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_1_clk_n]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_1_data_p[*]]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_1_data_n[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_p[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_1_data_n[*]]

set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_1_clk_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_1_clk_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_1_data_p[*]]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_1_data_n[*]]

# MIPI interface 2
#set_property PACKAGE_PIN AW40 [get_ports {mipi_phy_if_2_clk_p}]; # LA18_CC_P
#set_property PACKAGE_PIN AY40 [get_ports {mipi_phy_if_2_clk_n}]; # LA18_CC_N
#set_property PACKAGE_PIN AV38 [get_ports {mipi_phy_if_2_data_p[0]}]; # LA24_P
#set_property PACKAGE_PIN AW39 [get_ports {mipi_phy_if_2_data_n[0]}]; # LA24_N
#set_property PACKAGE_PIN AV36 [get_ports {mipi_phy_if_2_data_p[1]}]; # LA17_CC_P
#set_property PACKAGE_PIN AW37 [get_ports {mipi_phy_if_2_data_n[1]}]; # LA17_CC_N

#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_2_clk_p]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_2_clk_n]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_2_data_p[*]]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_2_data_n[*]]

#set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_2_clk_p]
#set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_2_clk_n]
#set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_2_data_p[*]]
#set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_2_data_n[*]]

# MIPI interface 3
set_property PACKAGE_PIN AR40 [get_ports {mipi_phy_if_3_clk_p}]; # LA31_P
set_property PACKAGE_PIN AT39 [get_ports {mipi_phy_if_3_clk_n}]; # LA31_N
set_property PACKAGE_PIN AR42 [get_ports {mipi_phy_if_3_data_p[0]}]; # LA33_P
set_property PACKAGE_PIN AT42 [get_ports {mipi_phy_if_3_data_n[0]}]; # LA33_N
set_property PACKAGE_PIN BA36 [get_ports {mipi_phy_if_3_data_p[1]}]; # LA28_P
set_property PACKAGE_PIN BB36 [get_ports {mipi_phy_if_3_data_n[1]}]; # LA28_N

#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_3_clk_p]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_3_clk_n]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_3_data_p[*]]
#set_property IOSTANDARD MIPI_DPHY_DCI [get_ports mipi_phy_if_3_data_n[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_3_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_3_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_3_data_p[*]]
set_property IOSTANDARD MIPI_DPHY [get_ports mipi_phy_if_3_data_n[*]]

set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_3_clk_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_3_clk_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_3_data_p[*]]
set_property DIFF_TERM_ADV TERM_100 [get_ports mipi_phy_if_3_data_n[*]]


#[Mig 66-441] Memory/Advanced IO Wizard core Error - [ADVWIZIO-8]: [vek280_camerafmc_i/mipi_2/csirx_0/inst/phy/inst/inst/slave_rx.bd_38e7_phy_0_rx_hssio_i] Nibble/s(3) of (706) Bank/s is/are being used by other bus interface, place this signal group in another nibble group of the I/O Bank 
#[Opt 31-306] MIG/Advanced IO Wizard Cores generation Failed.
