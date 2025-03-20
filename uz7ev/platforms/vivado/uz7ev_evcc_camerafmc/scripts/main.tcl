
set proj_name uz7ev_evcc_camerafmc
set proj_dir ./project
set proj_board avnet-tria:ultrazed_7ev_cc:part0:1.6
set bd_tcl_dir ./scripts
set board ultrazed_7ev_cc
set rev None
set output {xsa}
set xdc_list {./xdc/pin.xdc}
set ip_repo_path {./ip}
#set ip_repo_path {../ip}
set src_repo_path {./src}
set jobs 8

# parse arguments
for { set i 0 } { $i < $argc } { incr i } {
  # jobs
  if { [lindex $argv $i] == "-jobs" } {
    incr i
    set jobs [lindex $argv $i]
  }
}

# set board repo path
set bdf_path [file normalize [pwd]/../../../../common/platforms/bdf]
if {[expr {![catch {file lstat $bdf_path finfo}]}]} {
   set_param board.repoPaths $bdf_path
   puts "\n\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
   puts " Selected \n BDF path $bdf_path"
   puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n\n"
} else {
   puts "\n\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
   puts " Error specifying BDF path $bdf_path"
   puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n\n"
   return -code ok
}

create_project -name $proj_name -force -dir $proj_dir -part [get_property PART_NAME [get_board_parts $proj_board]]
set_property board_part $proj_board [current_project]

import_files -fileset constrs_1 $xdc_list

set_property ip_repo_paths $ip_repo_path [current_project]
update_ip_catalog

# Create block diagram design and set as current design
set design_name $proj_name
create_bd_design $proj_name
current_bd_design $proj_name

# Set current bd instance as root of current design
set parentCell [get_bd_cells /]
set parentObj [get_bd_cells $parentCell]
current_bd_instance $parentObj

source $bd_tcl_dir/config_bd.tcl
save_bd_design


make_wrapper -files [get_files $proj_dir/${proj_name}.srcs/sources_1/bd/$proj_name/${proj_name}.bd] -top
import_files -force -norecurse $proj_dir/${proj_name}.srcs/sources_1/bd/$proj_name/hdl/${proj_name}_wrapper.v
update_compile_order
set_property top ${proj_name}_wrapper [current_fileset]
update_compile_order -fileset sources_1


save_bd_design
validate_bd_design
generate_target all [get_files $proj_dir/${proj_name}.srcs/sources_1/bd/$proj_name/${proj_name}.bd]


set fd [open $proj_dir/README.hw w]

puts $fd "##########################################################################"
puts $fd "This is a brief document containing design specific details for : ${board}"
puts $fd "This is auto-generated by Petalinux ref-design builder created @ [clock format [clock seconds] -format {%a %b %d %H:%M:%S %Z %Y}]"
puts $fd "##########################################################################"

set board_part [get_board_parts [current_board_part -quiet]]
if { $board_part != ""} {
	puts $fd "BOARD: $board_part"
}

set design_name [get_property NAME [get_bd_designs]]
puts $fd "BLOCK DESIGN: $design_name"


set columns {%40s%30s%15s%50s}
puts $fd [string repeat - 150]
puts $fd [format $columns "MODULE INSTANCE NAME" "IP TYPE" "IP VERSION" "IP"]
puts $fd [string repeat - 150]

foreach ip [get_ips] {
	set catlg_ip [get_ipdefs -all [get_property IPDEF $ip]]
	puts $fd [format $columns [get_property NAME $ip] [get_property NAME $catlg_ip] [get_property VERSION $catlg_ip] [get_property VLNV $catlg_ip]]
}

close $fd

set_property synth_checkpoint_mode Hierarchical [get_files $proj_dir/${proj_name}.srcs/sources_1/bd/$proj_name/${proj_name}.bd]
#launch_runs synth_1 -jobs $jobs
#wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs $jobs
wait_on_run impl_1
open_run impl_1

set_property platform.board_id $proj_name [current_project]

set_property platform.default_output_type "xclbin" [current_project]

set_property platform.design_intent.datacenter false [current_project]

set_property platform.design_intent.embedded true [current_project]

set_property platform.design_intent.external_host false [current_project]

set_property platform.design_intent.server_managed false [current_project]

set_property platform.extensible true [current_project]

set_property platform.platform_state "pre_synth" [current_project]

set_property platform.name $proj_name [current_project]

set_property platform.vendor "tria" [current_project]

set_property platform.version "1.0" [current_project]

#write_hw_platform -force -file $proj_dir/${proj_name}.xsa
write_hw_platform -force -file $proj_dir/${proj_name}.xsa -include_bit
validate_hw_platform -verbose $proj_dir/${proj_name}.xsa

exit

