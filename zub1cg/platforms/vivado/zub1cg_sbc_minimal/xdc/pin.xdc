#######################################################################
# DisplayPort HPD & AUX
#######################################################################
set_property IOSTANDARD LVCMOS12 [get_ports {dp_hot_plug_detect*}]
set_property IOSTANDARD LVCMOS12 [get_ports {dp_aux_data*}]

set_property PACKAGE_PIN K1 [get_ports dp_aux_data_out_0 ]; # HP_DP_15_P 
set_property PACKAGE_PIN J1 [get_ports dp_hot_plug_detect_0 ]; # HP_DP_15_N 
set_property PACKAGE_PIN D2 [get_ports dp_aux_data_oe_0 ]; # HP_DP_24_P 
set_property PACKAGE_PIN C2 [get_ports dp_aux_data_in_0 ]; # HP_DP_24_N 
