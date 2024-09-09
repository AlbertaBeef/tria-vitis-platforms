#
# Set I/O standards
#
set_property IOSTANDARD LVCMOS18 [get_ports {pl_pb*}]
set_property IOSTANDARD LVCMOS18 [get_ports {rgb_led*}]
set_property IOSTANDARD LVCMOS18 [get_ports {click*}]
set_property IOSTANDARD LVCMOS18 [get_ports {tempsensor*}]

#
# Set I/O location constraints
#
set_property PACKAGE_PIN A8 [get_ports pl_pb_tri_i ]; # HD_GPIO_PB1 

set_property PACKAGE_PIN A7 [get_ports {rgb_led_0_tri_o[0]}]; # HD_GPIO_RGB1_R 
set_property PACKAGE_PIN B6 [get_ports {rgb_led_0_tri_o[1]}]; # HD_GPIO_RGB1_G 
set_property PACKAGE_PIN B5 [get_ports {rgb_led_0_tri_o[2]}]; # HD_GPIO_RGB1_B 

set_property PACKAGE_PIN B4 [get_ports {rgb_led_1_tri_o[0]}]; # HP_GPIO_RGB2_R 
set_property PACKAGE_PIN A2 [get_ports {rgb_led_1_tri_o[1]}]; # HP_GPIO_RGB2_G 
set_property PACKAGE_PIN F4 [get_ports {rgb_led_1_tri_o[2]}]; # HP_GPIO_RGB2_B 

#
# Set Click I/O constraints
#

set_property PACKAGE_PIN G7 [get_ports {click_spi_pl_ss_io[0]}]
set_property PACKAGE_PIN G5 [get_ports {click_spi_pl_ss_io[1]}]

set_property IOSTANDARD LVCMOS18 [get_ports {click_spi_pl_ss_io[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {click_spi_pl_ss_io[0]}]

#######################################################################
# DisplayPort HPD & AUX
#######################################################################
set_property IOSTANDARD LVCMOS18 [get_ports {dp_hot_plug_detect*}]
set_property IOSTANDARD LVCMOS18 [get_ports {dp_aux_data*}]

set_property PACKAGE_PIN K1 [get_ports dp_aux_data_out_0 ]; # HP_DP_15_P 
set_property PACKAGE_PIN J1 [get_ports dp_hot_plug_detect_0 ]; # HP_DP_15_N 
set_property PACKAGE_PIN D2 [get_ports dp_aux_data_oe_0 ]; # HP_DP_24_P 
set_property PACKAGE_PIN C2 [get_ports dp_aux_data_in_0 ]; # HP_DP_24_N 
