
#Get parameters from base instance


#Get parameters from base instance

# setting additional WDI params

set_property BITSTREAM.GENERAL.NPIDMAMODE Yes [current_design]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]




#set_property PACKAGE_PIN AU38 [get_ports sys_diff_clock_clk_p]
#set_property PACKAGE_PIN AU39 [get_ports sys_diff_clock_clk_n]

####################################################################################
# LEDs
####################################################################################

# GPIO_LED_0_LS -> XPIO_702_L26_N
set_property PACKAGE_PIN M25 [get_ports LED0]
set_property IOSTANDARD LVCMOS12 [get_ports LED0]

####################################################################################
# MIPI CAM0
####################################################################################

# MIPI2 - CAM0
#set_property PACKAGE_PIN J27 [get_ports rpi_rx_0_mipi_clk_p]
#set_property PACKAGE_PIN H28 [get_ports rpi_rx_0_mipi_clk_n]
#set_property PACKAGE_PIN H27 [get_ports {rpi_rx_0_mipi_data_p[0]}]
#set_property PACKAGE_PIN G28 [get_ports {rpi_rx_0_mipi_data_n[0]}]
#set_property PACKAGE_PIN G27 [get_ports {rpi_rx_0_mipi_data_p[1]}]
#set_property PACKAGE_PIN F28 [get_ports {rpi_rx_0_mipi_data_n[1]}]
#set_property PACKAGE_PIN E27 [get_ports {rpi_rx_0_mipi_data_p[2]}]
#set_property PACKAGE_PIN E28 [get_ports {rpi_rx_0_mipi_data_n[2]}]
#set_property PACKAGE_PIN D27 [get_ports {rpi_rx_0_mipi_data_p[3]}]
#set_property PACKAGE_PIN C28 [get_ports {rpi_rx_0_mipi_data_n[3]}]

### IIC (MIO)

# CAMERA 0 - I2C-SDA - MIPI0_SDA_3V3 - <I2C-MUX> - LPD_MIO23_I2C0_SDA - JX1A-A16 - LPD_MIO23 - LPD_MIO23_502 - Y7
# CAMERA 0 - I2C-SCL - MIPI0_SCL_3V3 - <I2C-MUX> - LPD_MIO22_I2C0_SCL - JX1A-A17 - LPD_MIO22 - LPD_MIO22_502 - T6


### GPIO

# CAMERA 0 - GPIO0 - XPIO_703_L5_3V3_N - <LEVEL-SHIFTER> - XPIO_703_L5_N - JX2B-D4 - B28
set_property PACKAGE_PIN B28 [get_ports {rpi_rx_0_gpio_tri_o[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_0_gpio_tri_o[0]}]

# CAMERA 0 - GPIO1 - XPIO_703_L5_3V3_P - <LEVEL-SHIFTER> - XPIO_703_L5_p - JX2B-D3 - C27
set_property PACKAGE_PIN C27 [get_ports {rpi_rx_0_gpio_tri_o[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_0_gpio_tri_o[1]}]

### MIPI

# CAMERA 0 - CLK - XPIO_703_XCC_L0_P/N - JX2B-D9/D10 - J27/H28
set_property PACKAGE_PIN J27     [get_ports rpi_rx_0_mipi_clk_p];
set_property PACKAGE_PIN H28     [get_ports rpi_rx_0_mipi_clk_n];

# CAMERA 0 - D0 - XPIO_703_L1_P/N - JX2B-C6/C7 - H27/G28
set_property PACKAGE_PIN H27     [get_ports {rpi_rx_0_mipi_data_p[0]}];
set_property PACKAGE_PIN G28     [get_ports {rpi_rx_0_mipi_data_n[0]}];

# CAMERA 0 - D1 - XPIO_703_L2_P/N - JX2B-D6/D7 - G27/F28
set_property PACKAGE_PIN G27     [get_ports {rpi_rx_0_mipi_data_p[1]}];
set_property PACKAGE_PIN F28     [get_ports {rpi_rx_0_mipi_data_n[1]}];

set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_0_mipi_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_0_mipi_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_0_mipi_data_p[*]}]
set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_0_mipi_data_n[*]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports rpi_rx_0_mipi_clk*]
set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_0_mipi_data_p[*]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_0_mipi_data_n[*]}]

####################################################################################
# MIPI CAM1
####################################################################################

# MIPI3 - CAM1
#set_property PACKAGE_PIN H25 [get_ports rpi_rx_1_mipi_clk_p]
#set_property PACKAGE_PIN J26 [get_ports rpi_rx_1_mipi_clk_n]
#set_property PACKAGE_PIN G25 [get_ports {rpi_rx_1_mipi_data_p[0]}]
#set_property PACKAGE_PIN G26 [get_ports {rpi_rx_1_mipi_data_n[0]}]
#set_property PACKAGE_PIN F26 [get_ports {rpi_rx_1_mipi_data_p[1]}]
#set_property PACKAGE_PIN E26 [get_ports {rpi_rx_1_mipi_data_n[1]}]
#set_property PACKAGE_PIN C25 [get_ports {rpi_rx_1_mipi_data_p[2]}]
#set_property PACKAGE_PIN B25 [get_ports {rpi_rx_1_mipi_data_n[2]}]
#set_property PACKAGE_PIN A25 [get_ports {rpi_rx_1_mipi_data_p[3]}]
#set_property PACKAGE_PIN A26 [get_ports {rpi_rx_1_mipi_data_n[3]}]

### IIC (MIO)

# CAMERA 1 - I2C-SDA - MIPI1_SDA_3V3 - <I2C-MUX> - LPD_MIO23_I2C0_SDA - JX1A-A16 - LPD_MIO23 - LPD_MIO23_502 - Y7
# CAMERA 1 - I2C-SCL - MIPI1_SCL_3V3 - <I2C-MUX> - LPD_MIO22_I2C0_SCL - JX1A-A17 - LPD_MIO22 - LPD_MIO22_502 - T6

### GPIO

# CAMERA 1 - GPIO0 - XPIO_703_L11_3V3_N - <LEVEL-SHIFTER> - XPIO_703_L11_N - JX2A-A7 - B27
set_property PACKAGE_PIN B27 [get_ports {rpi_rx_1_gpio_tri_o[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_1_gpio_tri_o[0]}]

# CAMERA 1 - GPIO1 - XPIO_703_L11_3V3_P - <LEVEL-SHIFTER> - XPIO_703_L11_p - JX2A-A6 - B26
set_property PACKAGE_PIN B26 [get_ports {rpi_rx_1_gpio_tri_o[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_1_gpio_tri_o[1]}]

### MIPI

# CAMERA 1 - CLK - XPIO_703_GC_XCC_L6_P/N - JX2B-D19/D19 - H25/J26
set_property PACKAGE_PIN H25     [get_ports rpi_rx_1_mipi_clk_p];
set_property PACKAGE_PIN J26     [get_ports rpi_rx_1_mipi_clk_n];

# CAMERA 1 - D0 - XPIO_703_L7_P/N - JX2B-C15/C16 - G25/G26
set_property PACKAGE_PIN G25     [get_ports {rpi_rx_1_mipi_data_p[0]}];
set_property PACKAGE_PIN G26     [get_ports {rpi_rx_1_mipi_data_n[0]}];

# CAMERA 1 - D1 - XPIO_703_L8_P/N - JX2B-D15/D16 - F26/E26
set_property PACKAGE_PIN F26     [get_ports {rpi_rx_1_mipi_data_p[1]}];
set_property PACKAGE_PIN E26     [get_ports {rpi_rx_1_mipi_data_n[1]}];

set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_1_mipi_clk_p]
set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_1_mipi_clk_n]
set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_1_mipi_data_p[*]}]
set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_1_mipi_data_n[*]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports rpi_rx_1_mipi_clk*]
set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_1_mipi_data_p[*]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_1_mipi_data_n[*]}]

####################################################################################
# MIPI CAM2
####################################################################################

# MIPI4 - CAM2
#set_property PACKAGE_PIN H23 [get_ports rpi_rx_2_mipi_clk_p]
#set_property PACKAGE_PIN H24 [get_ports rpi_rx_2_mipi_clk_n]
#set_property PACKAGE_PIN F22 [get_ports {rpi_rx_2_mipi_data_p[0]}]
#set_property PACKAGE_PIN G23 [get_ports {rpi_rx_2_mipi_data_n[0]}]
#set_property PACKAGE_PIN E22 [get_ports {rpi_rx_2_mipi_data_p[1]}]
#set_property PACKAGE_PIN E23 [get_ports {rpi_rx_2_mipi_data_n[1]}]
#set_property PACKAGE_PIN D24 [get_ports {rpi_rx_2_mipi_data_p[2]}]
#set_property PACKAGE_PIN C24 [get_ports {rpi_rx_2_mipi_data_n[2]}]
#set_property PACKAGE_PIN C23 [get_ports {rpi_rx_2_mipi_data_p[3]}]
#set_property PACKAGE_PIN B23 [get_ports {rpi_rx_2_mipi_data_n[3]}]

### IIC (MIO)

# CAMERA 2 - I2C-SDA - MIPI2_SDA_3V3 - <I2C-MUX> - LPD_MIO23_I2C0_SDA - JX1A-A16 - LPD_MIO23 - LPD_MIO23_502 - Y7
# CAMERA 2 - I2C-SCL - MIPI2_SCL_3V3 - <I2C-MUX> - LPD_MIO22_I2C0_SCL - JX1A-A17 - LPD_MIO22 - LPD_MIO22_502 - T6

### GPIO

# CAMERA 2 - GPIO0 - XPIO_703_L17_3V3_N - <LEVEL-SHIFTER> - XPIO_703_L17_N - JX2A-B13 - A24
#set_property PACKAGE_PIN A24 [get_ports {rpi_rx_2_gpio_tri_o[0]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_2_gpio_tri_o[0]}]

# CAMERA 2 - GPIO1 - XPIO_703_L17_3V3_P - <LEVEL-SHIFTER> - XPIO_703_L17_p - JX2A-B12 - A23
#set_property PACKAGE_PIN A23 [get_ports {rpi_rx_2_gpio_tri_o[1]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_2_gpio_tri_o[1]}]

### MIPI

# CAMERA 2 - CLK - XPIO_703_GC_XCC_L12_P/N - JX2B-C21/C22 - H23/H24
#set_property PACKAGE_PIN H23     [get_ports rpi_rx_2_mipi_clk_p];
#set_property PACKAGE_PIN H24     [get_ports rpi_rx_2_mipi_clk_n];

# CAMERA 2 - D0 - XPIO_703_L13_P/N - JX2B-D21/D22 - F22/G23
#set_property PACKAGE_PIN F22     [get_ports {rpi_rx_2_mipi_data_p[0]}];
#set_property PACKAGE_PIN G23     [get_ports {rpi_rx_2_mipi_data_n[0]}];

# CAMERA 2 - D1 - XPIO_703_L14_P/N - JX2B-CV18/C19 - E22/E23
#set_property PACKAGE_PIN E22     [get_ports {rpi_rx_2_mipi_data_p[1]}];
#set_property PACKAGE_PIN E23     [get_ports {rpi_rx_2_mipi_data_n[1]}];

#set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_2_mipi_clk_p]
#set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_2_mipi_clk_n]
#set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_2_mipi_data_p[*]}]
#set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_2_mipi_data_n[*]}]
#set_property DIFF_TERM_ADV TERM_100 [get_ports rpi_rx_2_mipi_clk*]
#set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_2_mipi_data_p[*]}]
#set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_2_mipi_data_n[*]}]

####################################################################################
# MIPI CAM3
####################################################################################

# MIPI5 - CAM3
#set_property PACKAGE_PIN G21 [get_ports rpi_rx_3_mipi_clk_p]
#set_property PACKAGE_PIN H22 [get_ports rpi_rx_3_mipi_clk_n]
#set_property PACKAGE_PIN E20 [get_ports {rpi_rx_3_mipi_data_p[0]}]
#set_property PACKAGE_PIN F21 [get_ports {rpi_rx_3_mipi_data_n[0]}]
#set_property PACKAGE_PIN D20 [get_ports {rpi_rx_3_mipi_data_p[1]}]
#set_property PACKAGE_PIN D21 [get_ports {rpi_rx_3_mipi_data_n[1]}]
#set_property PACKAGE_PIN F23 [get_ports {rpi_rx_3_mipi_data_p[2]}]
#set_property PACKAGE_PIN F24 [get_ports {rpi_rx_3_mipi_data_n[2]}]
#set_property PACKAGE_PIN E24 [get_ports {rpi_rx_3_mipi_data_p[3]}]
#set_property PACKAGE_PIN F25 [get_ports {rpi_rx_3_mipi_data_n[3]}]


### IIC (MIO)

# CAMERA 3 - I2C-SDA - MIPI3_SDA_3V3 - <I2C-MUX> - LPD_MIO23_I2C0_SDA - JX1A-A16 - LPD_MIO23 - LPD_MIO23_502 - Y7
# CAMERA 3 - I2C-SCL - MIPI3_SCL_3V3 - <I2C-MUX> - LPD_MIO22_I2C0_SCL - JX1A-A17 - LPD_MIO22 - LPD_MIO22_502 - T6

### GPIO

# CAMERA 3 - GPIO0 - XPIO_703_L23_3V3_N - <LEVEL-SHIFTER> - XPIO_703_L23_N - JX2A-B19 - B22
#set_property PACKAGE_PIN B22 [get_ports {rpi_rx_3_gpio_tri_o[0]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_3_gpio_tri_o[0]}]

# CAMERA 3 - GPIO1 - XPIO_703_L23_3V3_P - <LEVEL-SHIFTER> - XPIO_703_L23_p - JX2A-B18 - C22
#set_property PACKAGE_PIN C22 [get_ports {rpi_rx_3_gpio_tri_o[1]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {rpi_rx_3_gpio_tri_o[1]}]

### MIPI

# CAMERA 3 - CLK - XPIO_703_XCC_L18_P/N - JX2A-A21/A22 - G21/H22
#set_property PACKAGE_PIN G21     [get_ports rpi_rx_3_mipi_clk_p];
#set_property PACKAGE_PIN H22     [get_ports rpi_rx_3_mipi_clk_n];

# CAMERA 3 - D0 - XPIO_703_L19_P/N - JX2A-B21/B22 - E20/F21
#set_property PACKAGE_PIN E20     [get_ports {rpi_rx_3_mipi_data_p[0]}];
#set_property PACKAGE_PIN F21     [get_ports {rpi_rx_3_mipi_data_n[0]}];

# CAMERA 3 - D1 - XPIO_703_L20_P/N - JX2A-A18/A19 - D20/D21
#set_property PACKAGE_PIN D20     [get_ports {rpi_rx_3_mipi_data_p[1]}];
#set_property PACKAGE_PIN D21     [get_ports {rpi_rx_3_mipi_data_n[1]}];

#set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_3_mipi_clk_p]
#set_property IOSTANDARD MIPI_DPHY [get_ports rpi_rx_3_mipi_clk_n]
#set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_3_mipi_data_p[*]}]
#set_property IOSTANDARD MIPI_DPHY [get_ports {rpi_rx_3_mipi_data_n[*]}]
#set_property DIFF_TERM_ADV TERM_100 [get_ports rpi_rx_3_mipi_clk*]
#set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_3_mipi_data_p[*]}]
#set_property DIFF_TERM_ADV TERM_100 [get_ports {rpi_rx_3_mipi_data_n[*]}]


####################################################################################
# HDMI TX
####################################################################################

#set_property PACKAGE_PIN Y30 [get_ports {GT_DRU_FRL_CLK_IN_clk_p[0]}]
#set_property PACKAGE_PIN AB30 [get_ports {TX_REFCLK_P_IN_V_clk_p[0]}]
#set_property PACKAGE_PIN AN16 [get_ports TX_HPD_IN]
#set_property PACKAGE_PIN AN15 [get_ports TX_DDC_OUT_scl_io]
#set_property PACKAGE_PIN AP15 [get_ports TX_DDC_OUT_sda_io]
#set_property PACKAGE_PIN AP14 [get_ports IDT8T49N241_LOL_IN]
#set_property PACKAGE_PIN AT17 [get_ports {rx_en[0]}]
#set_property PACKAGE_PIN AM16 [get_ports {tx_en[0]}]
#set_property PACKAGE_PIN AT16 [get_ports HDMI_CTRL_sda_io]
#set_property PACKAGE_PIN AR15 [get_ports HDMI_CTRL_scl_io]

#create_clock -period 2.500 [get_ports GT_DRU_FRL_CLK_IN_clk_p]
#create_clock -period 3.367 [get_ports TX_REFCLK_P_IN_V_clk_p]
#set_property IOSTANDARD LVCMOS15 [get_ports TX_HPD_IN]
#set_property IOSTANDARD LVCMOS15 [get_ports TX_DDC_OUT_scl_io]
#set_property IOSTANDARD LVCMOS15 [get_ports TX_DDC_OUT_sda_io]
#set_property IOSTANDARD LVCMOS15 [get_ports IDT8T49N241_LOL_IN]
#set_property IOSTANDARD LVCMOS15 [get_ports {rx_en[0]}]
#set_property IOSTANDARD LVCMOS15 [get_ports {tx_en[0]}]
#set_property IOSTANDARD LVCMOS15 [get_ports HDMI_CTRL_scl_io]
#set_property IOSTANDARD LVCMOS15 [get_ports HDMI_CTRL_sda_io]

# GTYP_104
set_property PACKAGE_PIN F2 [get_ports {GT_Serial_grx_p[0]}]
set_property PACKAGE_PIN E5 [get_ports {GT_Serial_gtx_p[0]}]
set_property PACKAGE_PIN D2 [get_ports {GT_Serial_grx_p[1]}]
set_property PACKAGE_PIN D8 [get_ports {GT_Serial_gtx_p[1]}]
set_property PACKAGE_PIN B2 [get_ports {GT_Serial_grx_p[2]}]
set_property PACKAGE_PIN C5 [get_ports {GT_Serial_gtx_p[2]}]
set_property PACKAGE_PIN A5 [get_ports {GT_Serial_grx_p[3]}]
set_property PACKAGE_PIN B8 [get_ports {GT_Serial_gtx_p[3]}]


# HDMI RX
# RCLKOUTP/N -> HDMI_RCLK_OUT_P/N -> GTYP_104_REFCLK0_P/N
set_property PACKAGE_PIN H7 [get_ports {HDMI_RX_CLK_P_IN_V_clk_p[0]}]
create_clock -period 3.367 [get_ports HDMI_RX_CLK_P_IN_V_clk_p]

# 100MHz Clock Originally from GTYP_REFCLK - Mapped to 156.25MHz GTYP_103_REFCLK0_P
# Leaving contraint at 100MHz from original reference design.
set_property PACKAGE_PIN M7 [get_ports {GT_DRU_FRL_CLK_IN_clk_p[0]}]
create_clock -period 2.500 [get_ports GT_DRU_FRL_CLK_IN_clk_p]

# HDMI_RX_HPD mapped to XPIO_702_L16_N_HRX_HPD
#set_property PACKAGE_PIN K24 [get_ports {RX_HPD_OUT[0]}]
#set_property IOSTANDARD LVCMOS12 [get_ports {RX_HPD_OUT[0]}]

# HDMI_RX_SNK_SCL mapped to XPIO_702_XCC_L18_P_HRX_SCL
#set_property PACKAGE_PIN V21 [get_ports RX_DDC_OUT_scl_io]
#set_property IOSTANDARD LVCMOS12 [get_ports RX_DDC_OUT_scl_io]

# HDMI_RX_SNK_SDA mapped to XPIO_702_XCC_L18_N_HRX_SDA
#set_property PACKAGE_PIN U22 [get_ports RX_DDC_OUT_sda_io]
#set_property IOSTANDARD LVCMOS12 [get_ports RX_DDC_OUT_sda_io]

# HDMI_RX_REFCLK_OU_P -> XPIO_702_L23_P_CLKIN_CG
set_property PACKAGE_PIN J21 [get_ports RX_REFCLK_P_OUT]
#set_property IOSTANDARD LVDS15 [get_ports RX_REFCLK_P_OUT]
# ERROR LVDS15 incompatible with 1.2V
#set_property IOSTANDARD LVDS12 [get_ports RX_REFCLK_P_OUT]
# [DRC NSTD-2] UNDEFINED I/O Standard issue: 2 out of 145 logical ports use I/O standard (IOSTANDARD) value 'UNDEFINED' or 'DIFF_UNDEFINED', instead of a user assigned specific value. This may cause I/O contention or incompatibility with the board power or connectivity affecting performance, signal integrity or in extreme cases cause damage to the device or the components to which it is connected. To correct this violation, specify all I/O standards. This design will fail to generate a bitstream unless all logical ports have a user specified I/O standard value defined. NOTE: This DRC is READONLY and cannot be waived. Problem ports: RX_REFCLK_P_OUT, and RX_REFCLK_N_OUT.
set_property IOSTANDARD DIFF_SSTL12 [get_ports RX_REFCLK_P_OUT]

# HDMI_RX_SIG_DET_OUT -> XPIO_702_L17_N_HRX_DETOUT
#set_property PACKAGE_PIN J24 [get_ports RX_DET_N_IN]
#set_property IOSTANDARD LVCMOS12 [get_ports RX_DET_N_IN]

# HDMI TX
# 297MHz Clock From Clock Generator -> GTYP_104_REFCLK1_P
set_property PACKAGE_PIN F7 [get_ports {TX_REFCLK_P_IN_V_clk_p[0]}]
create_clock -period 3.367 [get_ports TX_REFCLK_P_IN_V_clk_p]

# HDMI_TX_SRC_HPD -> XPIO_702_L19_N_HTX_HPD
set_property PACKAGE_PIN R22 [get_ports TX_HPD_IN]
set_property IOSTANDARD LVCMOS12 [get_ports TX_HPD_IN]

# HDMI_TX_SRC_SCL -> XPIO_702_L20_P_HTX_SCL
set_property PACKAGE_PIN R21 [get_ports TX_DDC_OUT_scl_io]
set_property IOSTANDARD LVCMOS12 [get_ports TX_DDC_OUT_scl_io]

# HDMI_TX_SRC_SDA -> XPIO_702_L20_N_HTX_SDA
set_property PACKAGE_PIN P22 [get_ports TX_DDC_OUT_sda_io]
set_property IOSTANDARD LVCMOS12 [get_ports TX_DDC_OUT_sda_io]

# HDMI_CTRL_SCL -> XPIO_702_L22_N_HCTL_SCL
set_property PACKAGE_PIN L22 [get_ports HDMI_CTRL_scl_io]
set_property IOSTANDARD LVCMOS12 [get_ports HDMI_CTRL_scl_io]

# HDMI_CTRL_SDA -> XPIO_702_L22_P_HCTL_SDA
set_property PACKAGE_PIN K21 [get_ports HDMI_CTRL_sda_io]
set_property IOSTANDARD LVCMOS12 [get_ports HDMI_CTRL_sda_io]



# PLL_LOSS_OF_LOCK - TIE TO A 702 PUSH BUTTON - XPIO_702_L26_P (LOW-NO PUSH / HIGH-WHEN PUSHED)
set_property PACKAGE_PIN N25 [get_ports IDT8T49N241_LOL_IN]
set_property IOSTANDARD LVCMOS12 [get_ports IDT8T49N241_LOL_IN]

# HDMI_RX_ENABLE_N -> XPIO_702_L16_P_HRX_ENB
set_property PACKAGE_PIN L23 [get_ports {rx_en[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {rx_en[0]}]

# HDMI_TX_ENABLE_N -> XPIO_702_L19_P_HTX_ENB
set_property PACKAGE_PIN T21 [get_ports {tx_en[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {tx_en[0]}]

#set_clock_uncertainty -hold 0.050 [get_clocks *pl_0]
# This DRC for Versal Tri-state buffer is waived off as the input of
# IIC tri-state buffer is never toggling. Input of the tri-state buffer is always 0


create_waiver -type DRC -id {RPBF-8} -user "kalyanch" -desc "Waiver for AR76846" -objects [get_cells TX_DDC_OUT_scl_iobuf] -timestamp "Mon Oct  3 04:37:15 GMT 2022"

create_waiver -type DRC -id {RPBF-8} -user "kalyanch" -desc "Waiver for AR76846" -objects [get_cells TX_DDC_OUT_sda_iobuf] -timestamp "Mon Oct  3 04:37:15 GMT 2022"


####################################################################################
# LPDDR
####################################################################################

# reference : https://support.xilinx.com/s/article/000035358
# The following is not working:
#set_property -dict [list CONFIG.MC_LP4_OVERWRITE_IO_PROP {true}] [get_bd_cells noc_mc_x1]

### RESOLVED
### - with all AXI_NOC configuration in one single core called "axi_noc_0", with 
#[Mig 66-441] Memory/Advanced IO Wizard core Error - [ADVWIZIO-13]: [ved2302_rpiRx_hdmiTx_i/noc_mc_x1/inst/MC0_ddrc, ved2302_rpiRx_hdmiTx_i/rpi_rx_0/csirx_0/inst/phy/inst/inst/bd_91a3_phy_0_rx_support_i/slave_rx.bd_91a3_phy_0_rx_hssio_i]Conflicting Vcc voltages in bank 702. The following ports in this bank have conflicting VCCOs:  rpi_rx_0_mipi_clk_n,rpi_rx_0_mipi_clk_p,rpi_rx_0_mipi_data_n[0],rpi_rx_0_mipi_data_n[1],rpi_rx_0_mipi_data_p[0],rpi_rx_0_mipi_data_p[1] (MIPI_DPHY, requiring VCCO =1.2) and ch0_lpddr4_trip1_reset_n,ch1_lpddr4_trip1_reset_n (LVCMOS15, requiring VCCO =1.5)
#[Mig 66-441] Memory/Advanced IO Wizard core Error - [ved2302_rpiRx_hdmiTx_i/noc_mc_x1/inst/MC0_ddrc, ved2302_rpiRx_hdmiTx_i/rpi_rx_0/csirx_0/inst/phy/inst/inst/bd_91a3_phy_0_rx_support_i/slave_rx.bd_91a3_phy_0_rx_hssio_i]Conflicting Vcc voltages in bank 702. The following ports in this bank have conflicting VCCOs:  rpi_rx_0_mipi_clk_n,rpi_rx_0_mipi_clk_p,rpi_rx_0_mipi_data_n[0],rpi_rx_0_mipi_data_n[1],rpi_rx_0_mipi_data_p[0],rpi_rx_0_mipi_data_p[1] (MIPI_DPHY, requiring VCCO =1.2) and ch0_lpddr4_trip1_reset_n,ch1_lpddr4_trip1_reset_n (LVCMOS15, requiring VCCO =1.5)

set_property IOSTANDARD LVDS15 [get_ports lpddr4_clk1_clk_p]
set_property IOSTANDARD LVDS15 [get_ports lpddr4_clk1_clk_n]

### UNRESOLVED 
#[DRC BIVC-1] Bank IO standard Vcc: Conflicting Vcc voltages in bank 702. For example, the following two ports in this bank have conflicting VCCOs:  lpddr4_clk1_clk_p (DIFF_SSTL15, requiring VCCO=1.500) and IDT8T49N241_LOL_IN (LVCMOS12, requiring VCCO=1.200)

set_property IOSTANDARD LVCMOS12 [get_ports IDT8T49N241_LOL_IN]

#[DRC BIVC-1] Bank IO standard Vcc: Conflicting Vcc voltages in bank 702. For example, the following two ports in this bank have conflicting VCCOs:  lpddr4_clk1_clk_p (DIFF_SSTL15, requiring VCCO=1.500) and TX_HPD_IN (LVCMOS12, requiring VCCO=1.200)

set_property IOSTANDARD LVCMOS12 [get_ports TX_HPD_IN]

#[DRC BIVC-1] Bank IO standard Vcc: Conflicting Vcc voltages in bank 702. For example, the following two ports in this bank have conflicting VCCOs:  IDT8T49N241_LOL_IN (LVCMOS12, requiring VCCO=1.200) and ch0_lpddr4_trip1_reset_n (LVCMOS15, requiring VCCO=1.500)

set_property IOSTANDARD LVCMOS12 [get_ports ch0_lpddr4_trip1_reset_n]
set_property IOSTANDARD LVCMOS12 [get_ports ch1_lpddr4_trip1_reset_n]

