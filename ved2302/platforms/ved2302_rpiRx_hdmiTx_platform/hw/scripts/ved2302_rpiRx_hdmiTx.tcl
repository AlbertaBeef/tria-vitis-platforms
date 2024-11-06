
################################################################
# This is a generated script based on design: ved2302_rpiRx_hdmiTx
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2023.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source ved2302_rpiRx_hdmiTx_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcve2302-sfva784-1LP-e-S-es1
   set_property BOARD_PART avnet.com:ve2302_iocc:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name ved2302_rpiRx_hdmiTx

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:versal_cips:*\
xilinx.com:ip:axi_noc:*\
xilinx.com:ip:axi_intc:*\
xilinx.com:ip:clk_wizard:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:smartconnect:*\
xilinx.com:ip:axi_vip:*\
xilinx.com:ip:ai_engine:*\
xilinx.com:ip:xlconcat:*\
xilinx.com:ip:axi_gpio:*\
xilinx.com:ip:v_proc_ss:*\
xilinx.com:ip:v_frmbuf_wr:*\
xilinx.com:ip:xlslice:*\
xilinx.com:hls:ISPPipeline_accel:*\
xilinx.com:ip:mipi_csi2_rx_subsystem:*\
xilinx.com:ip:axi_iic:*\
xilinx.com:ip:axis_register_slice:*\
xilinx.com:ip:v_hdmi_txss1:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:xpm_cdc_gen:*\
xilinx.com:ip:v_mix:*\
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:bufg_gt:*\
xilinx.com:ip:gt_quad_base:*\
xilinx.com:ip:hdmi_gt_controller:*\
xilinx.com:ip:util_reduced_logic:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hdmiphy_ss
proc create_hier_cell_hdmiphy_ss { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hdmiphy_ss() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 phy_data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 vid_phy_axi4lite_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 vid_phy_status_sb_tx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 vid_phy_tx_axi4s_ch0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 vid_phy_tx_axi4s_ch1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 vid_phy_tx_axi4s_ch2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 vid_phy_tx_axi4s_ch3


  # Create pins
  create_bd_pin -dir I -type clk drp_clk
  create_bd_pin -dir I -type clk dru_ref_clk_in
  create_bd_pin -dir I -type clk dru_ref_clk_odiv2_in
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir O -type gt_usrclk rxoutclk
  create_bd_pin -dir I -type clk tx_ref_clk_in
  create_bd_pin -dir I -type clk tx_ref_clk_odiv2_in
  create_bd_pin -dir I tx_refclk_rdy
  create_bd_pin -dir O -type clk tx_tmds_clk
  create_bd_pin -dir O -type clk tx_video_clk
  create_bd_pin -dir O -type gt_usrclk txoutclk
  create_bd_pin -dir I -type clk vid_phy_axi4lite_aclk
  create_bd_pin -dir I -type rst vid_phy_axi4lite_aresetn
  create_bd_pin -dir I -type clk vid_phy_sb_aclk
  create_bd_pin -dir I -type rst vid_phy_sb_aresetn
  create_bd_pin -dir I -type rst vid_phy_tx_axi4s_aresetn

  # Create instance: bufg_gt_rx, and set properties
  set bufg_gt_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_rx ]

  # Create instance: bufg_gt_tx, and set properties
  set bufg_gt_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_tx ]

  # Create instance: gt_quad_base, and set properties
  set gt_quad_base [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base gt_quad_base ]
  set_property -dict [list \
    CONFIG.PORTS_INFO_DICT {LANE_SEL_DICT {unconnected {RX0 RX1 RX2 RX3} PROT0 {TX0 TX1 TX2 TX3}} GT_TYPE GTYP REG_CONF_INTF APB3_INTF BOARD_PARAMETER { }} \
    CONFIG.PROT_OUTCLK_VALUES {CH0_RXOUTCLK 390.625 CH0_TXOUTCLK 200 CH1_RXOUTCLK 390.625 CH1_TXOUTCLK 200 CH2_RXOUTCLK 390.625 CH2_TXOUTCLK 200 CH3_RXOUTCLK 390.625 CH3_TXOUTCLK 200} \
    CONFIG.REFCLK_STRING {HSCLK0_LCPLLGTREFCLK1 refclk_PROT0_R1_multiple_ext_freq HSCLK0_LCPLLNORTHREFCLK0 refclk_PROT0_R2_400_MHz_unique1 HSCLK1_LCPLLGTREFCLK1 refclk_PROT0_R1_multiple_ext_freq HSCLK1_LCPLLNORTHREFCLK0\
refclk_PROT0_R2_400_MHz_unique1} \
  ] $gt_quad_base


  # Create instance: hdmi_gt_controller_0, and set properties
  set hdmi_gt_controller_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hdmi_gt_controller hdmi_gt_controller_0 ]
  set_property -dict [list \
    CONFIG.C_FOR_UPGRADE_SPEEDGRADE {-2LP} \
    CONFIG.C_Rx_Protocol {None} \
    CONFIG.C_SPEEDGRADE {-2LP} \
    CONFIG.C_Tx_Protocol {HDMI 2.1} \
    CONFIG.C_Txrefclk_Rdy_Invert {true} \
    CONFIG.Rx_GT_Line_Rate {6.0} \
    CONFIG.Rx_GT_Ref_Clock_Freq {400} \
    CONFIG.Tx_GT_Line_Rate {8.0} \
    CONFIG.Tx_GT_Ref_Clock_Freq {400} \
    CONFIG.Tx_Max_GT_Line_Rate {8.0} \
  ] $hdmi_gt_controller_0


  # Create instance: urlp, and set properties
  set urlp [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic urlp ]
  set_property CONFIG.C_SIZE {1} $urlp


  # Create instance: xlcp, and set properties
  set xlcp [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlcp ]
  set_property CONFIG.NUM_PORTS {1} $xlcp


  # Create interface connections
  connect_bd_intf_net -intf_net axi4lite_0_1 [get_bd_intf_pins vid_phy_axi4lite_0] [get_bd_intf_pins hdmi_gt_controller_0/axi4lite]
  connect_bd_intf_net -intf_net gt_quad_base_GT_Serial [get_bd_intf_pins phy_data] [get_bd_intf_pins gt_quad_base/GT_Serial]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_ch0_debug [get_bd_intf_pins gt_quad_base/CH0_DEBUG] [get_bd_intf_pins hdmi_gt_controller_0/ch0_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_ch1_debug [get_bd_intf_pins gt_quad_base/CH1_DEBUG] [get_bd_intf_pins hdmi_gt_controller_0/ch1_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_ch2_debug [get_bd_intf_pins gt_quad_base/CH2_DEBUG] [get_bd_intf_pins hdmi_gt_controller_0/ch2_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_ch3_debug [get_bd_intf_pins gt_quad_base/CH3_DEBUG] [get_bd_intf_pins hdmi_gt_controller_0/ch3_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_gt_debug [get_bd_intf_pins gt_quad_base/GT_DEBUG] [get_bd_intf_pins hdmi_gt_controller_0/gt_debug]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_gt_tx0 [get_bd_intf_pins gt_quad_base/TX0_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_0/gt_tx0]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_gt_tx1 [get_bd_intf_pins gt_quad_base/TX1_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_0/gt_tx1]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_gt_tx2 [get_bd_intf_pins gt_quad_base/TX2_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_0/gt_tx2]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_gt_tx3 [get_bd_intf_pins gt_quad_base/TX3_GT_IP_Interface] [get_bd_intf_pins hdmi_gt_controller_0/gt_tx3]
  connect_bd_intf_net -intf_net hdmi_gt_controller_0_status_sb_tx [get_bd_intf_pins vid_phy_status_sb_tx] [get_bd_intf_pins hdmi_gt_controller_0/status_sb_tx]
  connect_bd_intf_net -intf_net tx_axi4s_ch0_0_1 [get_bd_intf_pins vid_phy_tx_axi4s_ch0] [get_bd_intf_pins hdmi_gt_controller_0/tx_axi4s_ch0]
  connect_bd_intf_net -intf_net tx_axi4s_ch1_0_1 [get_bd_intf_pins vid_phy_tx_axi4s_ch1] [get_bd_intf_pins hdmi_gt_controller_0/tx_axi4s_ch1]
  connect_bd_intf_net -intf_net tx_axi4s_ch2_0_1 [get_bd_intf_pins vid_phy_tx_axi4s_ch2] [get_bd_intf_pins hdmi_gt_controller_0/tx_axi4s_ch2]
  connect_bd_intf_net -intf_net tx_axi4s_ch3_0_1 [get_bd_intf_pins vid_phy_tx_axi4s_ch3] [get_bd_intf_pins hdmi_gt_controller_0/tx_axi4s_ch3]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins dru_ref_clk_in] [get_bd_pins gt_quad_base/GT_REFCLK1]
  connect_bd_net -net apb_clk_0_1 [get_bd_pins drp_clk] [get_bd_pins gt_quad_base/apb3clk] [get_bd_pins hdmi_gt_controller_0/apb_clk]
  connect_bd_net -net axi4lite_aclk_0_1 [get_bd_pins vid_phy_axi4lite_aclk] [get_bd_pins hdmi_gt_controller_0/axi4lite_aclk]
  connect_bd_net -net axi4lite_aresetn_0_1 [get_bd_pins vid_phy_axi4lite_aresetn] [get_bd_pins hdmi_gt_controller_0/axi4lite_aresetn]
  connect_bd_net -net bufg_gt_1_usrclk1 [get_bd_pins bufg_gt_tx/usrclk] [get_bd_pins txoutclk] [get_bd_pins gt_quad_base/ch0_txusrclk] [get_bd_pins gt_quad_base/ch1_txusrclk] [get_bd_pins gt_quad_base/ch2_txusrclk] [get_bd_pins gt_quad_base/ch3_txusrclk] [get_bd_pins hdmi_gt_controller_0/gt_txusrclk] [get_bd_pins hdmi_gt_controller_0/tx_axi4s_aclk]
  connect_bd_net -net bufg_gt_usrclk1 [get_bd_pins bufg_gt_rx/usrclk] [get_bd_pins rxoutclk] [get_bd_pins gt_quad_base/ch0_rxusrclk] [get_bd_pins gt_quad_base/ch1_rxusrclk] [get_bd_pins gt_quad_base/ch2_rxusrclk] [get_bd_pins gt_quad_base/ch3_rxusrclk]
  connect_bd_net -net gt_quad_base_ch0_iloresetdone [get_bd_pins gt_quad_base/ch0_iloresetdone] [get_bd_pins hdmi_gt_controller_0/gt_ch0_ilo_resetdone]
  connect_bd_net -net gt_quad_base_ch0_rxoutclk [get_bd_pins gt_quad_base/ch0_rxoutclk] [get_bd_pins bufg_gt_rx/outclk]
  connect_bd_net -net gt_quad_base_ch0_txoutclk [get_bd_pins gt_quad_base/ch0_txoutclk] [get_bd_pins bufg_gt_tx/outclk]
  connect_bd_net -net gt_quad_base_ch1_iloresetdone [get_bd_pins gt_quad_base/ch1_iloresetdone] [get_bd_pins hdmi_gt_controller_0/gt_ch1_ilo_resetdone]
  connect_bd_net -net gt_quad_base_ch2_iloresetdone [get_bd_pins gt_quad_base/ch2_iloresetdone] [get_bd_pins hdmi_gt_controller_0/gt_ch2_ilo_resetdone]
  connect_bd_net -net gt_quad_base_ch3_iloresetdone [get_bd_pins gt_quad_base/ch3_iloresetdone] [get_bd_pins hdmi_gt_controller_0/gt_ch3_ilo_resetdone]
  connect_bd_net -net gt_quad_base_gtpowergood [get_bd_pins gt_quad_base/gtpowergood] [get_bd_pins xlcp/In0]
  connect_bd_net -net gt_quad_base_hsclk0_lcplllock [get_bd_pins gt_quad_base/hsclk0_lcplllock] [get_bd_pins hdmi_gt_controller_0/gt_lcpll0_lock]
  connect_bd_net -net gt_quad_base_hsclk1_lcplllock [get_bd_pins gt_quad_base/hsclk1_lcplllock] [get_bd_pins hdmi_gt_controller_0/gt_lcpll1_lock]
  connect_bd_net -net gt_refclk1_odiv2_0_1 [get_bd_pins tx_ref_clk_odiv2_in] [get_bd_pins hdmi_gt_controller_0/gt_refclk1_odiv2]
  connect_bd_net -net gt_refclk2_odiv2_0_1 [get_bd_pins dru_ref_clk_odiv2_in] [get_bd_pins hdmi_gt_controller_0/gt_refclk2_odiv2]
  connect_bd_net -net hdmi_gt_controller_0_gt_lcpll0_reset [get_bd_pins hdmi_gt_controller_0/gt_lcpll0_reset] [get_bd_pins gt_quad_base/hsclk0_lcpllreset]
  connect_bd_net -net hdmi_gt_controller_0_gt_lcpll1_reset [get_bd_pins hdmi_gt_controller_0/gt_lcpll1_reset] [get_bd_pins gt_quad_base/hsclk1_lcpllreset]
  connect_bd_net -net hdmi_gt_controller_0_irq [get_bd_pins hdmi_gt_controller_0/irq] [get_bd_pins irq]
  connect_bd_net -net hdmi_gt_controller_0_tx_tmds_clk [get_bd_pins hdmi_gt_controller_0/tx_tmds_clk] [get_bd_pins tx_tmds_clk]
  connect_bd_net -net hdmi_gt_controller_0_tx_video_clk [get_bd_pins hdmi_gt_controller_0/tx_video_clk] [get_bd_pins tx_video_clk]
  connect_bd_net -net sb_aclk_0_1 [get_bd_pins vid_phy_sb_aclk] [get_bd_pins hdmi_gt_controller_0/sb_aclk]
  connect_bd_net -net sb_aresetn_0_1 [get_bd_pins vid_phy_sb_aresetn] [get_bd_pins hdmi_gt_controller_0/sb_aresetn]
  connect_bd_net -net tx_axi4s_aresetn_0_1 [get_bd_pins vid_phy_tx_axi4s_aresetn] [get_bd_pins hdmi_gt_controller_0/tx_axi4s_aresetn]
  connect_bd_net -net tx_ref_clk_in_1 [get_bd_pins tx_ref_clk_in] [get_bd_pins gt_quad_base/GT_REFCLK0]
  connect_bd_net -net tx_refclk_rdy_0_1 [get_bd_pins tx_refclk_rdy] [get_bd_pins hdmi_gt_controller_0/tx_refclk_rdy]
  connect_bd_net -net urlp_Res [get_bd_pins urlp/Res] [get_bd_pins hdmi_gt_controller_0/gtpowergood]
  connect_bd_net -net xlcp_dout [get_bd_pins xlcp/dout] [get_bd_pins urlp/Op1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gt_refclk_buf_ss_1
proc create_hier_cell_gt_refclk_buf_ss_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_gt_refclk_buf_ss_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 IBUFDSGT_IN


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 IBUFDSGT_ODIV2_OUT
  create_bd_pin -dir O -from 0 -to 0 IBUFDSGT_OUT

  # Create instance: bufg_gt, and set properties
  set bufg_gt [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf bufg_gt ]
  set_property CONFIG.C_BUF_TYPE {BUFG_GT} $bufg_gt


  # Create instance: ibufdsgte, and set properties
  set ibufdsgte [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf ibufdsgte ]
  set_property CONFIG.C_BUF_TYPE {IBUFDSGTE} $ibufdsgte


  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc_const ]
  set_property CONFIG.CONST_VAL {1} $vcc_const


  # Create interface connections
  connect_bd_intf_net -intf_net intf_net_bdry_in_IBUFDSGT_IN [get_bd_intf_pins IBUFDSGT_IN] [get_bd_intf_pins ibufdsgte/CLK_IN_D]

  # Create port connections
  connect_bd_net -net net_bufg_gt_BUFG_GT_O [get_bd_pins bufg_gt/BUFG_GT_O] [get_bd_pins IBUFDSGT_ODIV2_OUT]
  connect_bd_net -net net_ibufdsgte_IBUF_DS_ODIV2 [get_bd_pins ibufdsgte/IBUF_DS_ODIV2] [get_bd_pins bufg_gt/BUFG_GT_I]
  connect_bd_net -net net_ibufdsgte_IBUF_OUT [get_bd_pins ibufdsgte/IBUF_OUT] [get_bd_pins IBUFDSGT_OUT]
  connect_bd_net -net net_vcc_const_dout [get_bd_pins vcc_const/dout] [get_bd_pins bufg_gt/BUFG_GT_CE]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gt_refclk_buf_ss_0
proc create_hier_cell_gt_refclk_buf_ss_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_gt_refclk_buf_ss_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 IBUFDSGT_IN


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 IBUFDSGT_ODIV2_OUT
  create_bd_pin -dir O -from 0 -to 0 IBUFDSGT_OUT

  # Create instance: bufg_gt, and set properties
  set bufg_gt [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf bufg_gt ]
  set_property CONFIG.C_BUF_TYPE {BUFG_GT} $bufg_gt


  # Create instance: ibufdsgte, and set properties
  set ibufdsgte [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf ibufdsgte ]
  set_property CONFIG.C_BUF_TYPE {IBUFDSGTE} $ibufdsgte


  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc_const ]
  set_property CONFIG.CONST_VAL {1} $vcc_const


  # Create interface connections
  connect_bd_intf_net -intf_net intf_net_bdry_in_IBUFDSGT_IN [get_bd_intf_pins IBUFDSGT_IN] [get_bd_intf_pins ibufdsgte/CLK_IN_D]

  # Create port connections
  connect_bd_net -net net_bufg_gt_BUFG_GT_O [get_bd_pins bufg_gt/BUFG_GT_O] [get_bd_pins IBUFDSGT_ODIV2_OUT]
  connect_bd_net -net net_ibufdsgte_IBUF_DS_ODIV2 [get_bd_pins ibufdsgte/IBUF_DS_ODIV2] [get_bd_pins bufg_gt/BUFG_GT_I]
  connect_bd_net -net net_ibufdsgte_IBUF_OUT [get_bd_pins ibufdsgte/IBUF_OUT] [get_bd_pins IBUFDSGT_OUT]
  connect_bd_net -net net_vcc_const_dout [get_bd_pins vcc_const/dout] [get_bd_pins bufg_gt/BUFG_GT_CE]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_tx_0
proc create_hier_cell_hdmi_tx_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hdmi_tx_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DRU_FRL_CLK_IN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 GT_Serial

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 hdmi_s_axi_ctrl

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 TX_REFCLK_P_IN_V

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 hdmi_vfbr_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTRL


  # Create pins
  create_bd_pin -dir I IDT8T49N241_LOL_IN
  create_bd_pin -dir I TX_HPD_IN
  create_bd_pin -dir I -type clk frl_clk
  create_bd_pin -dir O -type intr hdmitx_ss_irq
  create_bd_pin -dir O -type intr hdmiphy_ss_irq
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk s_axis_video_aclk
  create_bd_pin -dir I -type rst s_axis_video_aresetn
  create_bd_pin -dir O -from 0 -to 0 tx_en
  create_bd_pin -dir O -type intr hdmi_vfbr_irq
  create_bd_pin -dir O hdmi_ctrl_irq

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property CONFIG.C_ALL_OUTPUTS {1} $axi_gpio_0


  # Create instance: gt_refclk_buf_ss_0
  create_hier_cell_gt_refclk_buf_ss_0 $hier_obj gt_refclk_buf_ss_0

  # Create instance: gt_refclk_buf_ss_1
  create_hier_cell_gt_refclk_buf_ss_1 $hier_obj gt_refclk_buf_ss_1

  # Create instance: hdmiphy_ss
  create_hier_cell_hdmiphy_ss $hier_obj hdmiphy_ss

  # Create instance: tx_video_axis_reg_slice, and set properties
  set tx_video_axis_reg_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice tx_video_axis_reg_slice ]

  # Create instance: v_hdmi_txss1_0, and set properties
  set v_hdmi_txss1_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_txss1 v_hdmi_txss1_0 ]
  set_property -dict [list \
    CONFIG.C_HPD_INVERT {true} \
    CONFIG.C_INPUT_PIXELS_PER_CLOCK {4} \
    CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
    CONFIG.C_MAX_FRL_RATE {4} \
  ] $v_hdmi_txss1_0


  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant vcc_const ]
  set_property CONFIG.CONST_VAL {1} $vcc_const


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {1} \
    CONFIG.DIN_TO {1} \
  ] $xlslice_1


  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_0


  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: fid_regslice, and set properties
  set fid_regslice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xpm_cdc_gen fid_regslice ]
  set_property -dict [list \
    CONFIG.CDC_TYPE {xpm_cdc_single} \
    CONFIG.DEST_SYNC_FF {4} \
    CONFIG.INIT_SYNC_FF {true} \
    CONFIG.SIM_ASSERT_CHK {false} \
    CONFIG.WIDTH {1} \
  ] $fid_regslice


  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]

  # Create instance: v_mix_0, and set properties
  set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {64} \
    CONFIG.LAYER1_ALPHA {true} \
    CONFIG.LAYER1_VIDEO_FORMAT {29} \
    CONFIG.NR_LAYERS {2} \
    CONFIG.SAMPLES_PER_CLOCK {4} \
  ] $v_mix_0


  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_1 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {96} \
  ] $xlconstant_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins GT_DRU_FRL_CLK_IN] [get_bd_intf_pins gt_refclk_buf_ss_0/IBUFDSGT_IN]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins TX_REFCLK_P_IN_V] [get_bd_intf_pins gt_refclk_buf_ss_1/IBUFDSGT_IN]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins axi_iic_0/IIC] [get_bd_intf_pins HDMI_CTRL]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins hdmi_s_axi_ctrl] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net hdmiphy_ss_phy_data [get_bd_intf_pins GT_Serial] [get_bd_intf_pins hdmiphy_ss/phy_data]
  connect_bd_intf_net -intf_net hdmiphy_ss_vid_phy_status_sb_tx [get_bd_intf_pins hdmiphy_ss/vid_phy_status_sb_tx] [get_bd_intf_pins v_hdmi_txss1_0/SB_STATUS_IN]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins axi_gpio_0/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins axi_iic_0/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins smartconnect_0/M02_AXI] [get_bd_intf_pins hdmiphy_ss/vid_phy_axi4lite_0]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_0/M03_AXI] [get_bd_intf_pins v_hdmi_txss1_0/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins smartconnect_0/M04_AXI] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net tx_video_axis_reg_slice_M_AXIS [get_bd_intf_pins tx_video_axis_reg_slice/M_AXIS] [get_bd_intf_pins v_hdmi_txss1_0/VIDEO_IN]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_DDC_OUT [get_bd_intf_pins TX_DDC_OUT] [get_bd_intf_pins v_hdmi_txss1_0/DDC_OUT]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_LINK_DATA0_OUT [get_bd_intf_pins hdmiphy_ss/vid_phy_tx_axi4s_ch0] [get_bd_intf_pins v_hdmi_txss1_0/LINK_DATA0_OUT]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_LINK_DATA1_OUT [get_bd_intf_pins hdmiphy_ss/vid_phy_tx_axi4s_ch1] [get_bd_intf_pins v_hdmi_txss1_0/LINK_DATA1_OUT]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_LINK_DATA2_OUT [get_bd_intf_pins hdmiphy_ss/vid_phy_tx_axi4s_ch2] [get_bd_intf_pins v_hdmi_txss1_0/LINK_DATA2_OUT]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_LINK_DATA3_OUT [get_bd_intf_pins hdmiphy_ss/vid_phy_tx_axi4s_ch3] [get_bd_intf_pins v_hdmi_txss1_0/LINK_DATA3_OUT]
  connect_bd_intf_net -intf_net v_mix_0_m_axi_mm_video1 [get_bd_intf_pins hdmi_vfbr_VIDEO] [get_bd_intf_pins v_mix_0/m_axi_mm_video1]
  connect_bd_intf_net -intf_net v_mix_0_m_axis_video [get_bd_intf_pins tx_video_axis_reg_slice/S_AXIS] [get_bd_intf_pins v_mix_0/m_axis_video]

  # Create port connections
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins hdmi_ctrl_irq]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins s_axis_video_aclk] [get_bd_pins tx_video_axis_reg_slice/aclk] [get_bd_pins v_hdmi_txss1_0/s_axis_video_aclk] [get_bd_pins smartconnect_0/aclk1] [get_bd_pins fid_regslice/dest_clk] [get_bd_pins fid_regslice/src_clk] [get_bd_pins v_mix_0/ap_clk]
  connect_bd_net -net dru_ref_clk_in_1 [get_bd_pins gt_refclk_buf_ss_0/IBUFDSGT_OUT] [get_bd_pins hdmiphy_ss/dru_ref_clk_in]
  connect_bd_net -net dru_ref_clk_odiv2_in_1 [get_bd_pins gt_refclk_buf_ss_0/IBUFDSGT_ODIV2_OUT] [get_bd_pins hdmiphy_ss/dru_ref_clk_odiv2_in]
  connect_bd_net -net fid_regslice_dest_out [get_bd_pins fid_regslice/dest_out] [get_bd_pins v_hdmi_txss1_0/fid]
  connect_bd_net -net hdmi_tx_irq_1 [get_bd_pins v_hdmi_txss1_0/irq] [get_bd_pins hdmitx_ss_irq]
  connect_bd_net -net net_bdry_in_IDT8T49N241_LOL_IN [get_bd_pins IDT8T49N241_LOL_IN] [get_bd_pins hdmiphy_ss/tx_refclk_rdy]
  connect_bd_net -net net_bdry_in_TX_HPD_IN [get_bd_pins TX_HPD_IN] [get_bd_pins v_hdmi_txss1_0/hpd]
  connect_bd_net -net net_cips_ss_0_frl_clk [get_bd_pins frl_clk] [get_bd_pins v_hdmi_txss1_0/frl_clk]
  connect_bd_net -net net_cips_ss_0_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins hdmiphy_ss/vid_phy_axi4lite_aresetn] [get_bd_pins hdmiphy_ss/vid_phy_sb_aresetn] [get_bd_pins v_hdmi_txss1_0/s_axi_cpu_aresetn] [get_bd_pins v_hdmi_txss1_0/s_axis_audio_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net net_cips_ss_0_s_axi_aclk [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins hdmiphy_ss/drp_clk] [get_bd_pins hdmiphy_ss/vid_phy_axi4lite_aclk] [get_bd_pins hdmiphy_ss/vid_phy_sb_aclk] [get_bd_pins v_hdmi_txss1_0/s_axi_cpu_aclk] [get_bd_pins v_hdmi_txss1_0/s_axis_audio_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net net_hdmiphy_ss_0_tx_video_clk [get_bd_pins hdmiphy_ss/tx_video_clk] [get_bd_pins v_hdmi_txss1_0/video_clk]
  connect_bd_net -net net_hdmiphy_ss_0_txoutclk [get_bd_pins hdmiphy_ss/txoutclk] [get_bd_pins v_hdmi_txss1_0/link_clk]
  connect_bd_net -net net_vcc_const_dout [get_bd_pins vcc_const/dout] [get_bd_pins hdmiphy_ss/vid_phy_tx_axi4s_aresetn] [get_bd_pins v_hdmi_txss1_0/video_cke_in]
  connect_bd_net -net proc_sysrst1_peripheral_aresetn [get_bd_pins s_axis_video_aresetn] [get_bd_pins tx_video_axis_reg_slice/aresetn] [get_bd_pins v_hdmi_txss1_0/s_axis_video_aresetn]
  connect_bd_net -net tx_ref_clk_in_1 [get_bd_pins gt_refclk_buf_ss_1/IBUFDSGT_OUT] [get_bd_pins hdmiphy_ss/tx_ref_clk_in]
  connect_bd_net -net tx_ref_clk_odiv2_in_1 [get_bd_pins gt_refclk_buf_ss_1/IBUFDSGT_ODIV2_OUT] [get_bd_pins hdmiphy_ss/tx_ref_clk_odiv2_in]
  connect_bd_net -net v_mix_0_interrupt [get_bd_pins v_mix_0/interrupt] [get_bd_pins hdmi_vfbr_irq]
  connect_bd_net -net vphy_irq_1 [get_bd_pins hdmiphy_ss/irq] [get_bd_pins hdmiphy_ss_irq]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_0/dout] [get_bd_pins fid_regslice/src_in]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xlconstant_1/dout] [get_bd_pins v_mix_0/s_axis_video_TDATA] [get_bd_pins v_mix_0/s_axis_video_TVALID]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins v_mix_0/ap_rst_n]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_pins tx_en]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: rpi_rx_0
proc create_hier_cell_rpi_rx_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_rpi_rx_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 vfbw_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO_sensor

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_sensor

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 mipi_s_axi_ctrl

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_csi


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -type intr vfbw_irq
  create_bd_pin -dir I -type clk video_clk
  create_bd_pin -dir I -type rst video_rst_n
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir O pll_lock_out
  create_bd_pin -dir O isp_irq

  # Create instance: v_proc_csc_0, and set properties
  set v_proc_csc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_csc_0 ]
  set_property -dict [list \
    CONFIG.C_ENABLE_CSC {true} \
    CONFIG.C_MAX_COLS {1920} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_ROWS {1232} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_TOPOLOGY {0} \
  ] $v_proc_csc_0


  # Create instance: vfbw, and set properties
  set vfbw [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr vfbw ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {32} \
    CONFIG.AXIMM_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {64} \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.HAS_UYVY8 {1} \
    CONFIG.HAS_Y8 {0} \
    CONFIG.HAS_YUV8 {1} \
    CONFIG.HAS_YUVX8 {1} \
    CONFIG.HAS_YUYV8 {1} \
    CONFIG.HAS_Y_UV8 {1} \
    CONFIG.HAS_Y_UV8_420 {1} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_NR_PLANES {2} \
    CONFIG.MAX_ROWS {1232} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $vfbw


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {1} \
    CONFIG.DIN_TO {1} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_1


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {2} \
    CONFIG.DIN_TO {2} \
    CONFIG.DOUT_WIDTH {1} \
  ] $xlslice_2


  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: csirx_0, and set properties
  set csirx_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem csirx_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_NUM_PIXELS {1} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_BUF_DEPTH {2048} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
    CONFIG.C_DPHY_LANES {2} \
    CONFIG.C_HS_LINE_RATE {1440} \
    CONFIG.C_HS_SETTLE_NS {158} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {420} \
    CONFIG.SupportLevel {1} \
  ] $csirx_0


  # Create instance: axigpiosen, and set properties
  set axigpiosen [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axigpiosen ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_DOUT_DEFAULT {0x00000006} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $axigpiosen


  # Create instance: axi_iic_sen, and set properties
  set axi_iic_sen [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_sen ]
  set_property CONFIG.IIC_FREQ_KHZ {100} $axi_iic_sen


  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {6} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_0


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins axigpiosen/GPIO] [get_bd_intf_pins GPIO_sensor]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins axi_iic_sen/IIC] [get_bd_intf_pins IIC_sensor]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins csirx_0/mipi_phy_if] [get_bd_intf_pins mipi_phy_csi]
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video] [get_bd_intf_pins v_proc_csc_0/s_axis]
  connect_bd_intf_net -intf_net csirx_0_video_out [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video] [get_bd_intf_pins csirx_0/video_out]
  connect_bd_intf_net -intf_net mipi_s_axi_1 [get_bd_intf_pins mipi_s_axi_ctrl] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins axigpiosen/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins axi_iic_sen/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins smartconnect_0/M02_AXI] [get_bd_intf_pins csirx_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL] [get_bd_intf_pins smartconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins v_proc_csc_0/s_axi_ctrl] [get_bd_intf_pins smartconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M05_AXI [get_bd_intf_pins smartconnect_0/M05_AXI] [get_bd_intf_pins vfbw/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_proc_csc_0_m_axis [get_bd_intf_pins v_proc_csc_0/m_axis] [get_bd_intf_pins vfbw/s_axis_video]
  connect_bd_intf_net -intf_net vfbw_m_axi_mm_video [get_bd_intf_pins vfbw_VIDEO] [get_bd_intf_pins vfbw/m_axi_mm_video]

  # Create port connections
  connect_bd_net -net ISPPipeline_accel_0_interrupt [get_bd_pins ISPPipeline_accel_0/interrupt] [get_bd_pins isp_irq]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din]
  connect_bd_net -net axi_iic_sen_iic2intc_irpt [get_bd_pins axi_iic_sen/iic2intc_irpt] [get_bd_pins iic2intc_irpt]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_clk] [get_bd_pins vfbw/ap_clk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins v_proc_csc_0/aclk_axis] [get_bd_pins v_proc_csc_0/aclk_ctrl] [get_bd_pins csirx_0/video_aclk] [get_bd_pins smartconnect_0/aclk1]
  connect_bd_net -net csirx_0_csirxss_csi_irq [get_bd_pins csirx_0/csirxss_csi_irq] [get_bd_pins csirxss_csi_irq]
  connect_bd_net -net csirx_0_pll_lock_out [get_bd_pins csirx_0/pll_lock_out] [get_bd_pins pll_lock_out]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins csirx_0/dphy_clk_200M]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_iic_sen/s_axi_aclk] [get_bd_pins axigpiosen/s_axi_aclk] [get_bd_pins csirx_0/lite_aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_iic_sen/s_axi_aresetn] [get_bd_pins axigpiosen/s_axi_aresetn] [get_bd_pins csirx_0/lite_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net vfbw_interrupt [get_bd_pins vfbw/interrupt] [get_bd_pins vfbw_irq]
  connect_bd_net -net video_rst_n_1 [get_bd_pins video_rst_n] [get_bd_pins csirx_0/video_aresetn]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins ISPPipeline_accel_0/ap_rst_n]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_pins v_proc_csc_0/aresetn_ctrl]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins vfbw/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ch0_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip1 ]

  set ch1_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip1 ]

  set lpddr4_clk1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk1 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200200200} \
   ] $lpddr4_clk1

  set rpi_rx_0_GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_rx_0_GPIO ]

  set rpi_rx_0_mipi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 rpi_rx_0_mipi ]

  set GT_DRU_FRL_CLK_IN [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DRU_FRL_CLK_IN ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {400000000} \
   ] $GT_DRU_FRL_CLK_IN

  set GT_Serial [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 GT_Serial ]

  set HDMI_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTRL ]

  set TX_DDC_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT ]

  set TX_REFCLK_P_IN_V [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 TX_REFCLK_P_IN_V ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $TX_REFCLK_P_IN_V


  # Create ports
  #set led_out [ create_bd_port -dir O -from 3 -to 0 led_out ]
  set led_out [ create_bd_port -dir O -from 0 -to 0 led_out ]
  set IDT8T49N241_LOL_IN [ create_bd_port -dir I IDT8T49N241_LOL_IN ]
  set TX_HPD_IN [ create_bd_port -dir I TX_HPD_IN ]
  set rx_en [ create_bd_port -dir O -from 0 -to 0 rx_en ]
  set tx_en [ create_bd_port -dir O -from 0 -to 0 tx_en ]

  # Create instance: CIPS_0, and set properties
  set CIPS_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips CIPS_0 ]
  set_property -dict [list \
    CONFIG.DDR_MEMORY_MODE {Custom} \
    CONFIG.DEBUG_MODE {JTAG} \
    CONFIG.DESIGN_MODE {1} \
    CONFIG.DEVICE_INTEGRITY_MODE {Custom} \
    CONFIG.PS_BOARD_INTERFACE {Custom} \
    CONFIG.PS_PL_CONNECTIVITY_MODE {Custom} \
    CONFIG.PS_PMC_CONFIG { \
      DDR_MEMORY_MODE {Connectivity to DDR via NOC} \
      DEBUG_MODE {JTAG} \
      DESIGN_MODE {1} \
      DEVICE_INTEGRITY_MODE {Custom} \
      PMC_CRP_HSM0_REF_CTRL_FREQMHZ {33.334} \
      PMC_CRP_HSM1_REF_CTRL_FREQMHZ {133.334} \
      PMC_CRP_PL0_REF_CTRL_FREQMHZ {100} \
      PMC_GPIO0_MIO_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 0 .. 25}}} \
      PMC_GPIO1_MIO_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 26 .. 51}}} \
      PMC_I2CPMC_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 50 .. 51}}} \
      PMC_OSPI_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 0 .. 11}} {MODE Single}} \
      PMC_REF_CLK_FREQMHZ {33.3333} \
      PMC_SD0 {{CD_ENABLE 0} {CD_IO {PMC_MIO 24}} {POW_ENABLE 1} {POW_IO {PMC_MIO 49}} {RESET_ENABLE 0} {RESET_IO {PMC_MIO 17}} {WP_ENABLE 1} {WP_IO {PMC_MIO 37}}} \
      PMC_SD0_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x3} {CLK_200_SDR_OTAP_DLY 0x2} {CLK_50_DDR_ITAP_DLY 0x36} {CLK_50_DDR_OTAP_DLY 0x3} {CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x4} {ENABLE 1} {IO {PMC_MIO 37 .. 49}}} \
      PMC_SD0_SLOT_TYPE {SD 3.0} \
      PMC_SD1_DATA_TRANSFER_MODE {8Bit} \
      PMC_SD1_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x00} {CLK_200_SDR_OTAP_DLY 0x2} {CLK_50_DDR_ITAP_DLY 0x1E} {CLK_50_DDR_OTAP_DLY 0x5} {CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x5} {ENABLE 1} {IO {PMC_MIO 26 .. 36}}} \
      PMC_SD1_SLOT_TYPE {eMMC} \
      PMC_USE_PMC_NOC_AXI0 {1} \
      PS_BOARD_INTERFACE {Custom} \
      PS_CAN0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 14 .. 15}}} \
      PS_CAN1_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 20 .. 21}}} \
      PS_ENET0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 0 .. 11}}} \
      PS_ENET1_PERIPHERAL {{ENABLE 0} {IO {PMC_MIO 38 .. 49}}} \
      PS_GEN_IPI0_ENABLE {1} \
      PS_GEN_IPI0_MASTER {A72} \
      PS_GEN_IPI1_ENABLE {1} \
      PS_GEN_IPI2_ENABLE {1} \
      PS_GEN_IPI3_ENABLE {1} \
      PS_GEN_IPI4_ENABLE {1} \
      PS_GEN_IPI5_ENABLE {1} \
      PS_GEN_IPI6_ENABLE {1} \
      PS_HSDP_EGRESS_TRAFFIC {JTAG} \
      PS_HSDP_INGRESS_TRAFFIC {JTAG} \
      PS_HSDP_MODE {NONE} \
      PS_I2C0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 18 .. 19}}} \
      PS_IRQ_USAGE {{CH0 1} {CH1 1} {CH10 0} {CH11 0} {CH12 0} {CH13 0} {CH14 0} {CH15 0} {CH2 0} {CH3 0} {CH4 0} {CH5 0} {CH6 0} {CH7 0} {CH8 0} {CH9 0}} \
      PS_LPDMA0_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA1_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA2_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA3_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA4_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA5_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA6_ROUTE_THROUGH_FPD {1} \
      PS_LPDMA7_ROUTE_THROUGH_FPD {1} \
      PS_MIO7 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} \
      PS_MIO9 {{AUX_IO 0} {DIRECTION in} {DRIVE_STRENGTH 8mA} {OUTPUT_DATA default} {PULL disable} {SCHMITT 0} {SLEW slow} {USAGE Reserved}} \
      PS_NUM_FABRIC_RESETS {1} \
      PS_PCIE_EP_RESET1_IO {None} \
      PS_PCIE_EP_RESET2_IO {None} \
      PS_PCIE_RESET {{ENABLE 1}} \
      PS_UART0_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 16 .. 17}}} \
      PS_UART1_PERIPHERAL {{ENABLE 1} {IO {PS_MIO 12 .. 13}}} \
      PS_USB3_PERIPHERAL {{ENABLE 1} {IO {PMC_MIO 13 .. 25}}} \
      PS_USE_FPD_AXI_NOC0 {1} \
      PS_USE_FPD_AXI_NOC1 {1} \
      PS_USE_FPD_CCI_NOC {1} \
      PS_USE_M_AXI_FPD {1} \
      PS_USE_M_AXI_LPD {0} \
      PS_USE_NOC_LPD_AXI0 {1} \
      PS_USE_PMCPL_CLK0 {1} \
      PS_USE_PMCPL_CLK1 {0} \
      PS_USE_PMCPL_CLK2 {0} \
      PS_USE_PMCPL_CLK3 {0} \
      SMON_ALARMS {Set_Alarms_On} \
      SMON_ENABLE_TEMP_AVERAGING {0} \
      SMON_INTERFACE_TO_USE {None} \
      SMON_MEAS20 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PMC} {SUPPLY_NUM 2}} \
      SMON_MEAS21 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PSFP} {SUPPLY_NUM 3}} \
      SMON_MEAS22 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PSLP} {SUPPLY_NUM 4}} \
      SMON_MEAS24 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_SOC} {SUPPLY_NUM 0}} \
      SMON_MEAS25 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VP_VN} {SUPPLY_NUM 1}} \
      SMON_MEAS44 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PMC} {SUPPLY_NUM 2}} \
      SMON_MEAS45 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PSFP} {SUPPLY_NUM 3}} \
      SMON_MEAS46 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_PSLP} {SUPPLY_NUM 4}} \
      SMON_MEAS48 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCC_SOC} {SUPPLY_NUM 5}} \
      SMON_MEAS49 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VP_VN} {SUPPLY_NUM 6}} \
      SMON_MEAS6 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCCAUX} {SUPPLY_NUM 5}} \
      SMON_MEAS7 {{ALARM_ENABLE 1} {ALARM_LOWER 0.00} {ALARM_UPPER 2.00} {AVERAGE_EN 0} {ENABLE 1} {MODE {2 V unipolar}} {NAME VCCAUX_PMC} {SUPPLY_NUM 6}} \
      SMON_TEMP_AVERAGING_SAMPLES {0} \
    } \
    CONFIG.PS_PMC_CONFIG_APPLIED {1} \
  ] $CIPS_0


  # Create instance: cips_noc, and set properties
  set cips_noc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc cips_noc ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {10} \
    CONFIG.NUM_MC {0} \
    CONFIG.NUM_MI {0} \
    CONFIG.NUM_NMI {5} \
    CONFIG.NUM_NSI {0} \
    CONFIG.NUM_SI {10} \
  ] $cips_noc


  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /cips_noc/M00_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /cips_noc/M01_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /cips_noc/M02_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /cips_noc/M03_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
 ] [get_bd_intf_pins /cips_noc/M04_INI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M04_INI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {128} write_bw {128}} M05_INI { read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S00_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M04_INI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M01_INI { read_bw {128} write_bw {128}} M06_INI { read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S01_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M04_INI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M02_INI { read_bw {128} write_bw {128}} M07_INI { read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S02_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M04_INI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M03_INI { read_bw {128} write_bw {128}} M08_INI { read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S03_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M00_INI { read_bw {5} write_bw {5}} M05_INI { read_bw {5} write_bw {5}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /cips_noc/S04_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M00_INI { read_bw {5} write_bw {5}} M05_INI { read_bw {5} write_bw {5}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_nci} \
 ] [get_bd_intf_pins /cips_noc/S05_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M00_INI { read_bw {5} write_bw {5}} M05_INI { read_bw {5} write_bw {5}} } \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /cips_noc/S06_AXI]

  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.CONNECTIONS { M04_INI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M00_INI { read_bw {5} write_bw {5}} M05_INI { read_bw {5} write_bw {5}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /cips_noc/S07_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M01_INI {read_bw {500} write_bw {500}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S08_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M02_INI {read_bw {500} write_bw {500}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S09_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {} \
 ] [get_bd_pins /cips_noc/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /cips_noc/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /cips_noc/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /cips_noc/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /cips_noc/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /cips_noc/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /cips_noc/aclk6]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI} \
 ] [get_bd_pins /cips_noc/aclk7]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S07_AXI} \
 ] [get_bd_pins /cips_noc/aclk8]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S08_AXI:S09_AXI} \
 ] [get_bd_pins /cips_noc/aclk9]

  # Create instance: noc_mc_x1, and set properties
  set noc_mc_x1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc noc_mc_x1 ]
  set_property -dict [list \
    CONFIG.CH0_LPDDR4_0_BOARD_INTERFACE {ch0_lpddr4_trip1} \
    CONFIG.CH1_LPDDR4_0_BOARD_INTERFACE {ch1_lpddr4_trip1} \
    CONFIG.MC_CHANNEL_INTERLEAVING {false} \
    CONFIG.MC_CHAN_REGION1 {DDR_LOW1} \
    CONFIG.MC_LP4_OVERWRITE_IO_PROP {true} \
    CONFIG.MC_LP4_PIN_EFFICIENT {true} \
    CONFIG.NUM_CLKS {0} \
    CONFIG.NUM_MC {1} \
    CONFIG.NUM_MCP {4} \
    CONFIG.NUM_MI {0} \
    CONFIG.NUM_NSI {4} \
    CONFIG.NUM_SI {0} \
    CONFIG.sys_clk0_BOARD_INTERFACE {lpddr4_clk1} \
  ] $noc_mc_x1

  # based on ve2302_hdmi design
  set_property CONFIG.MC_CHANNEL_INTERLEAVING {false} [get_bd_cells noc_mc_x1]
  # based on ve2302_hdmi_2032p1 design
  set_property -dict [list \
    CONFIG.CONTROLLERTYPE {LPDDR4_SDRAM} \
    CONFIG.MC_CHAN_REGION1 {DDR_LOW1} \
    CONFIG.MC_FREQ_SEL {MEMORY_CLK_FROM_SYS_CLK} \
    CONFIG.MC_IP_TIMEPERIOD0_FOR_OP {5000} \
    CONFIG.MC_LP4_OVERWRITE_IO_PROP {true} \
    CONFIG.MC_LP4_PIN_EFFICIENT {true} \
    CONFIG.MC_MEMORY_SPEEDGRADE {LPDDR4-3733} \
    CONFIG.MC_NO_CHANNELS {Dual} \
  ] $noc_mc_x1


  # workaround to resolve I/O conflict between MIPI I/O and LPDDR I/O
  # [Mig 66-441] Memory/Advanced IO Wizard core Error - [ADVWIZIO-13]: [ved2302_rpiRx_hdmiTx_i/axi_noc_0/inst/MC0_ddrc, ved2302_rpiRx_hdmiTx_i/rpi_rx_0/csirx_0/inst/phy/inst/inst/bd_91a3_phy_0_rx_support_i/slave_rx.bd_91a3_phy_0_rx_hssio_i]Conflicting Vcc voltages in bank 702. The following ports in this bank have conflicting VCCOs:  rpi_rx_0_mipi_clk_n,rpi_rx_0_mipi_clk_p,rpi_rx_0_mipi_data_n[0],rpi_rx_0_mipi_data_n[1],rpi_rx_0_mipi_data_p[0],rpi_rx_0_mipi_data_p[1] (MIPI_DPHY, requiring VCCO =1.2) and ch0_lpddr4_trip1_reset_n,ch1_lpddr4_trip1_reset_n (LVCMOS15, requiring VCCO =1.5)  
  # [Mig 66-441] Memory/Advanced IO Wizard core Error - [ved2302_rpiRx_hdmiTx_i/axi_noc_0/inst/MC0_ddrc, ved2302_rpiRx_hdmiTx_i/rpi_rx_0/csirx_0/inst/phy/inst/inst/bd_91a3_phy_0_rx_support_i/slave_rx.bd_91a3_phy_0_rx_hssio_i]Conflicting Vcc voltages in bank 702. The following ports in this bank have conflicting VCCOs:  rpi_rx_0_mipi_clk_n,rpi_rx_0_mipi_clk_p,rpi_rx_0_mipi_data_n[0],rpi_rx_0_mipi_data_n[1],rpi_rx_0_mipi_data_p[0],rpi_rx_0_mipi_data_p[1] (MIPI_DPHY, requiring VCCO =1.2) and ch0_lpddr4_trip1_reset_n,ch1_lpddr4_trip1_reset_n (LVCMOS15, requiring VCCO =1.5)  
  # reference : https://support.xilinx.com/s/article/000035358
  set_property -dict [list CONFIG.MC_LP4_OVERWRITE_IO_PROP {true}] [get_bd_cells noc_mc_x1]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_mc_x1/S00_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_mc_x1/S01_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_2 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_mc_x1/S02_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_mc_x1/S03_INI]

  # Create instance: ConfigNoc, and set properties
  set ConfigNoc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc ConfigNoc ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {1} \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_NSI {1} \
    CONFIG.NUM_SI {0} \
  ] $ConfigNoc


  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M00_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS { M00_AXI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}}} \
 ] [get_bd_intf_pins /ConfigNoc/S00_INI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk0]

  # Create instance: axi_intc_parent, and set properties
  set axi_intc_parent [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc_parent ]
  set_property -dict [list \
    CONFIG.C_ASYNC_INTR {0xFFFFFFFF} \
    CONFIG.C_IRQ_CONNECTION {1} \
  ] $axi_intc_parent


  # Create instance: clk_wizard_0, and set properties
  set clk_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard clk_wizard_0 ]
  set_property -dict [list \
    CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
    CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
    CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
    CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
    CONFIG.CLKOUT_PORT {clk_out1_100mhz,clk_out2_150mhz,clk_out3_300mhz,clk_out4_250mhz,clk_out5_200mhz,clk_out6_400mhz,clk_out7_600mhz} \
    CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
    CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {100,150,300,250,200,400,600} \
    CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
    CONFIG.CLKOUT_USED {true,true,true,true,true,true,true} \
    CONFIG.JITTER_SEL {Min_O_Jitter} \
    CONFIG.PRIM_IN_FREQ {99.999908} \
    CONFIG.PRIM_SOURCE {Global_buffer} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_PHASE_ALIGNMENT {true} \
    CONFIG.USE_RESET {true} \
  ] $clk_wizard_0


  # Create instance: psr_100mhz, and set properties
  set psr_100mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_100mhz ]

  # Create instance: psr_150mhz, and set properties
  set psr_150mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_150mhz ]

  # Create instance: psr_300mhz, and set properties
  set psr_300mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_300mhz ]

  # Create instance: psr_250mhz, and set properties
  set psr_250mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_250mhz ]

  # Create instance: psr_200mhz, and set properties
  set psr_200mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_200mhz ]

  # Create instance: psr_400mhz, and set properties
  set psr_400mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_400mhz ]

  # Create instance: psr_600mhz, and set properties
  set psr_600mhz [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset psr_600mhz ]

  # Create instance: icn_ctrl_1, and set properties
  set icn_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect icn_ctrl_1 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {4} \
    CONFIG.NUM_SI {1} \
  ] $icn_ctrl_1


  # Create instance: icn_ctrl_2, and set properties
  set icn_ctrl_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect icn_ctrl_2 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {1} \
    CONFIG.NUM_MI {3} \
    CONFIG.NUM_SI {1} \
  ] $icn_ctrl_2


  # Create instance: dummy_slave_0, and set properties
  set dummy_slave_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip dummy_slave_0 ]
  set_property -dict [list \
    CONFIG.INTERFACE_MODE {SLAVE} \
    CONFIG.PROTOCOL {AXI4LITE} \
  ] $dummy_slave_0


  # Create instance: ai_engine_0, and set properties
  set ai_engine_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ai_engine ai_engine_0 ]

  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S00_AXI]

  # Create instance: rpi_rx_0
  create_hier_cell_rpi_rx_0 [current_bd_instance .] rpi_rx_0

  # Create instance: concat_leds, and set properties
  set concat_leds [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat concat_leds ]
  #set_property CONFIG.NUM_PORTS {4} $concat_leds
  set_property CONFIG.NUM_PORTS {1} $concat_leds


  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc_0 ]
  set_property CONFIG.C_IRQ_CONNECTION {1} $axi_intc_0


  # Create instance: concat_interrupts, and set properties
  set concat_interrupts [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat concat_interrupts ]
  set_property CONFIG.NUM_PORTS {9} $concat_interrupts


  # Create instance: gpio_resets, and set properties
  set gpio_resets [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio gpio_resets ]
  set_property CONFIG.C_ALL_OUTPUTS {1} $gpio_resets


  # Create instance: hdmi_tx_0
  create_hier_cell_hdmi_tx_0 [current_bd_instance .] hdmi_tx_0

  # Create instance: clk_wizard_1, and set properties
  set clk_wizard_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard clk_wizard_1 ]
  set_property -dict [list \
    CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
    CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
    CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
    CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
    CONFIG.CLKOUT_PORT {clk_out1_325mhz,clk_out2_300mhz,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
    CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
    CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {325,300.000,100.000,100.000,100.000,100.000,100.000} \
    CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
    CONFIG.CLKOUT_USED {true,true,false,false,false,false,false} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_RESET {true} \
  ] $clk_wizard_1


  # Create interface connections
  connect_bd_intf_net -intf_net CIPS_0_IF_PMC_NOC_AXI_0 [get_bd_intf_pins CIPS_0/PMC_NOC_AXI_0] [get_bd_intf_pins cips_noc/S07_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_CCI_NOC_0 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_0] [get_bd_intf_pins cips_noc/S00_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_CCI_NOC_1 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_1] [get_bd_intf_pins cips_noc/S01_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_CCI_NOC_2 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_2] [get_bd_intf_pins cips_noc/S02_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_CCI_NOC_3 [get_bd_intf_pins CIPS_0/FPD_CCI_NOC_3] [get_bd_intf_pins cips_noc/S03_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_AXI_NOC_0 [get_bd_intf_pins CIPS_0/FPD_AXI_NOC_0] [get_bd_intf_pins cips_noc/S04_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_FPD_AXI_NOC_1 [get_bd_intf_pins CIPS_0/FPD_AXI_NOC_1] [get_bd_intf_pins cips_noc/S05_AXI]
  connect_bd_intf_net -intf_net CIPS_0_IF_LPD_AXI_NOC_0 [get_bd_intf_pins CIPS_0/LPD_AXI_NOC_0] [get_bd_intf_pins cips_noc/S06_AXI]
  connect_bd_intf_net -intf_net CIPS_0_M_AXI_GP0 [get_bd_intf_pins CIPS_0/M_AXI_FPD] [get_bd_intf_pins icn_ctrl_1/S00_AXI]
  connect_bd_intf_net -intf_net ConfigNoc_M00_AXI [get_bd_intf_pins ConfigNoc/M00_AXI] [get_bd_intf_pins ai_engine_0/S00_AXI]
  connect_bd_intf_net -intf_net GT_DRU_FRL_CLK_IN_1 [get_bd_intf_ports GT_DRU_FRL_CLK_IN] [get_bd_intf_pins hdmi_tx_0/GT_DRU_FRL_CLK_IN]
  connect_bd_intf_net -intf_net TX_REFCLK_P_IN_V_1 [get_bd_intf_ports TX_REFCLK_P_IN_V] [get_bd_intf_pins hdmi_tx_0/TX_REFCLK_P_IN_V]
  connect_bd_intf_net -intf_net axi_noc_0_CH0_LPDDR4_0 [get_bd_intf_ports ch0_lpddr4_trip1] [get_bd_intf_pins noc_mc_x1/CH0_LPDDR4_0]
  connect_bd_intf_net -intf_net axi_noc_0_CH1_LPDDR4_0 [get_bd_intf_ports ch1_lpddr4_trip1] [get_bd_intf_pins noc_mc_x1/CH1_LPDDR4_0]
  connect_bd_intf_net -intf_net cips_noc_M00_INI [get_bd_intf_pins noc_mc_x1/S00_INI] [get_bd_intf_pins cips_noc/M00_INI]
  connect_bd_intf_net -intf_net cips_noc_M01_INI [get_bd_intf_pins noc_mc_x1/S01_INI] [get_bd_intf_pins cips_noc/M01_INI]
  connect_bd_intf_net -intf_net cips_noc_M02_INI [get_bd_intf_pins noc_mc_x1/S02_INI] [get_bd_intf_pins cips_noc/M02_INI]
  connect_bd_intf_net -intf_net cips_noc_M03_INI [get_bd_intf_pins noc_mc_x1/S03_INI] [get_bd_intf_pins cips_noc/M03_INI]
  connect_bd_intf_net -intf_net cips_noc_M04_INI [get_bd_intf_pins ConfigNoc/S00_INI] [get_bd_intf_pins cips_noc/M04_INI]
  connect_bd_intf_net -intf_net hdmi_tx_0_HDMI_CTRL [get_bd_intf_ports HDMI_CTRL] [get_bd_intf_pins hdmi_tx_0/HDMI_CTRL]
  connect_bd_intf_net -intf_net hdmi_tx_0_hdmi_vfbr_VIDEO [get_bd_intf_pins cips_noc/S09_AXI] [get_bd_intf_pins hdmi_tx_0/hdmi_vfbr_VIDEO]
  connect_bd_intf_net -intf_net hdmiphy_ss_phy_data [get_bd_intf_ports GT_Serial] [get_bd_intf_pins hdmi_tx_0/GT_Serial]
  connect_bd_intf_net -intf_net icn_ctrl_1_M00_AXI [get_bd_intf_pins axi_intc_parent/s_axi] [get_bd_intf_pins icn_ctrl_1/M00_AXI]
  connect_bd_intf_net -intf_net icn_ctrl_1_M01_AXI [get_bd_intf_pins icn_ctrl_1/M01_AXI] [get_bd_intf_pins icn_ctrl_2/S00_AXI]
  connect_bd_intf_net -intf_net icn_ctrl_1_M03_AXI [get_bd_intf_pins icn_ctrl_1/M03_AXI] [get_bd_intf_pins hdmi_tx_0/hdmi_s_axi_ctrl]
  connect_bd_intf_net -intf_net icn_ctrl_2_M00_AXI [get_bd_intf_pins icn_ctrl_2/M00_AXI] [get_bd_intf_pins dummy_slave_0/S_AXI]
  connect_bd_intf_net -intf_net icn_ctrl_2_M01_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins icn_ctrl_2/M01_AXI]
  connect_bd_intf_net -intf_net icn_ctrl_2_M02_AXI [get_bd_intf_pins gpio_resets/S_AXI] [get_bd_intf_pins icn_ctrl_2/M02_AXI]
  connect_bd_intf_net -intf_net lpddr4_clk1_1 [get_bd_intf_ports lpddr4_clk1] [get_bd_intf_pins noc_mc_x1/sys_clk0]
  connect_bd_intf_net -intf_net mipi_s_axi_ctrl_1 [get_bd_intf_pins rpi_rx_0/mipi_s_axi_ctrl] [get_bd_intf_pins icn_ctrl_1/M02_AXI]
  connect_bd_intf_net -intf_net rpi_rx_0_GPIO [get_bd_intf_ports rpi_rx_0_GPIO] [get_bd_intf_pins rpi_rx_0/GPIO_sensor]
  connect_bd_intf_net -intf_net rpi_rx_0_mipi [get_bd_intf_ports rpi_rx_0_mipi] [get_bd_intf_pins rpi_rx_0/mipi_phy_csi]
  connect_bd_intf_net -intf_net rpi_rx_0_vfbw_VIDEO [get_bd_intf_pins rpi_rx_0/vfbw_VIDEO] [get_bd_intf_pins cips_noc/S08_AXI]
  connect_bd_intf_net -intf_net v_hdmi_txss1_0_DDC_OUT [get_bd_intf_ports TX_DDC_OUT] [get_bd_intf_pins hdmi_tx_0/TX_DDC_OUT]

  # Create port connections
  connect_bd_net -net CIPS_0_pl_clk0 [get_bd_pins CIPS_0/pl0_ref_clk] [get_bd_pins clk_wizard_0/clk_in1] [get_bd_pins clk_wizard_1/clk_in1]
  connect_bd_net -net CIPS_0_pl_resetn1 [get_bd_pins CIPS_0/pl0_resetn] [get_bd_pins clk_wizard_0/resetn] [get_bd_pins psr_150mhz/ext_reset_in] [get_bd_pins psr_100mhz/ext_reset_in] [get_bd_pins psr_200mhz/ext_reset_in] [get_bd_pins psr_300mhz/ext_reset_in] [get_bd_pins psr_400mhz/ext_reset_in] [get_bd_pins psr_600mhz/ext_reset_in] [get_bd_pins psr_250mhz/ext_reset_in] [get_bd_pins clk_wizard_1/resetn]
  connect_bd_net -net CIPS_0_ps_pmc_noc_axi0_clk [get_bd_pins CIPS_0/pmc_axi_noc_axi0_clk] [get_bd_pins cips_noc/aclk8]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi0_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi0_clk] [get_bd_pins cips_noc/aclk1]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi1_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi1_clk] [get_bd_pins cips_noc/aclk2]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi2_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi2_clk] [get_bd_pins cips_noc/aclk3]
  connect_bd_net -net CIPS_0_ps_ps_noc_cci_axi3_clk [get_bd_pins CIPS_0/fpd_cci_noc_axi3_clk] [get_bd_pins cips_noc/aclk4]
  connect_bd_net -net CIPS_0_ps_ps_noc_nci_axi0_clk [get_bd_pins CIPS_0/fpd_axi_noc_axi0_clk] [get_bd_pins cips_noc/aclk5]
  connect_bd_net -net CIPS_0_ps_ps_noc_nci_axi1_clk [get_bd_pins CIPS_0/fpd_axi_noc_axi1_clk] [get_bd_pins cips_noc/aclk6]
  connect_bd_net -net CIPS_0_ps_ps_noc_rpu_axi0_clk [get_bd_pins CIPS_0/lpd_axi_noc_clk] [get_bd_pins cips_noc/aclk7]
  connect_bd_net -net ai_engine_1_s00_axi_aclk [get_bd_pins ai_engine_0/s00_axi_aclk] [get_bd_pins ConfigNoc/aclk0]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins CIPS_0/pl_ps_irq1]
  connect_bd_net -net axi_intc_3_irq [get_bd_pins axi_intc_parent/irq] [get_bd_pins CIPS_0/pl_ps_irq0]
  connect_bd_net -net clk_wizard_0_clk_out1_100mhz [get_bd_pins clk_wizard_0/clk_out1_100mhz] [get_bd_pins CIPS_0/m_axi_fpd_aclk] [get_bd_pins axi_intc_parent/s_axi_aclk] [get_bd_pins cips_noc/aclk0] [get_bd_pins icn_ctrl_1/aclk] [get_bd_pins icn_ctrl_2/aclk] [get_bd_pins psr_100mhz/slowest_sync_clk] [get_bd_pins dummy_slave_0/aclk] [get_bd_pins rpi_rx_0/s_axi_aclk] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins gpio_resets/s_axi_aclk] [get_bd_pins hdmi_tx_0/s_axi_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2_150mhz [get_bd_pins clk_wizard_0/clk_out2_150mhz] [get_bd_pins psr_150mhz/slowest_sync_clk]
  connect_bd_net -net clk_wizard_0_clk_out3_300mhz [get_bd_pins clk_wizard_0/clk_out3_300mhz] [get_bd_pins psr_300mhz/slowest_sync_clk]
  connect_bd_net -net clk_wizard_0_clk_out4_250mhz [get_bd_pins clk_wizard_0/clk_out4_250mhz] [get_bd_pins psr_250mhz/slowest_sync_clk] [get_bd_pins rpi_rx_0/video_clk] [get_bd_pins icn_ctrl_1/aclk1] [get_bd_pins cips_noc/aclk9] [get_bd_pins hdmi_tx_0/s_axis_video_aclk]
  connect_bd_net -net clk_wizard_0_clk_out5_200mhz [get_bd_pins clk_wizard_0/clk_out5_200mhz] [get_bd_pins psr_200mhz/slowest_sync_clk] [get_bd_pins rpi_rx_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out6_400mhz [get_bd_pins clk_wizard_0/clk_out6_400mhz] [get_bd_pins psr_400mhz/slowest_sync_clk]
  connect_bd_net -net clk_wizard_0_clk_out7_600mhz [get_bd_pins clk_wizard_0/clk_out7_600mhz] [get_bd_pins psr_600mhz/slowest_sync_clk]
  connect_bd_net -net clk_wizard_0_locked [get_bd_pins clk_wizard_0/locked] [get_bd_pins psr_100mhz/dcm_locked] [get_bd_pins psr_150mhz/dcm_locked] [get_bd_pins psr_200mhz/dcm_locked] [get_bd_pins psr_300mhz/dcm_locked] [get_bd_pins psr_400mhz/dcm_locked] [get_bd_pins psr_600mhz/dcm_locked] [get_bd_pins psr_250mhz/dcm_locked]
  connect_bd_net -net clk_wizard_1_clk_out1_325mhz [get_bd_pins clk_wizard_1/clk_out1_325mhz] [get_bd_pins hdmi_tx_0/frl_clk]
  connect_bd_net -net concat_interrupts [get_bd_pins concat_interrupts/dout] [get_bd_pins axi_intc_0/intr]
  connect_bd_net -net gpio_resets [get_bd_pins gpio_resets/gpio_io_o] [get_bd_pins rpi_rx_0/Din]
  connect_bd_net -net hdmi_tx_0_hdmi_ctrl_irq [get_bd_pins hdmi_tx_0/hdmi_ctrl_irq] [get_bd_pins concat_interrupts/In8]
  connect_bd_net -net hdmi_tx_0_hdmi_vfbr_irq [get_bd_pins hdmi_tx_0/hdmi_vfbr_irq] [get_bd_pins concat_interrupts/In7]
  connect_bd_net -net hdmi_tx_0_hdmiphy_ss_irq [get_bd_pins hdmi_tx_0/hdmiphy_ss_irq] [get_bd_pins concat_interrupts/In4]
  connect_bd_net -net hdmi_tx_0_hdmitx_ss_irq [get_bd_pins hdmi_tx_0/hdmitx_ss_irq] [get_bd_pins concat_interrupts/In5]
  connect_bd_net -net hdmi_tx_tx_en [get_bd_pins hdmi_tx_0/tx_en] [get_bd_ports rx_en] [get_bd_ports tx_en]
  connect_bd_net -net net_bdry_in_IDT8T49N241_LOL_IN [get_bd_ports IDT8T49N241_LOL_IN] [get_bd_pins hdmi_tx_0/IDT8T49N241_LOL_IN]
  connect_bd_net -net net_bdry_in_TX_HPD_IN [get_bd_ports TX_HPD_IN] [get_bd_pins hdmi_tx_0/TX_HPD_IN]
  connect_bd_net -net psr_100mhz_peripheral_aresetn [get_bd_pins psr_100mhz/peripheral_aresetn] [get_bd_pins axi_intc_parent/s_axi_aresetn] [get_bd_pins icn_ctrl_1/aresetn] [get_bd_pins icn_ctrl_2/aresetn] [get_bd_pins dummy_slave_0/aresetn] [get_bd_pins rpi_rx_0/s_axi_aresetn] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins gpio_resets/s_axi_aresetn] [get_bd_pins hdmi_tx_0/s_axi_aresetn]
  connect_bd_net -net rpi_rx_0_csirxss_csi_irq [get_bd_pins rpi_rx_0/csirxss_csi_irq] [get_bd_pins concat_interrupts/In1]
  connect_bd_net -net rpi_rx_0_iic2intc_irpt [get_bd_pins rpi_rx_0/iic2intc_irpt] [get_bd_pins concat_interrupts/In0]
  connect_bd_net -net rpi_rx_0_isp_irq [get_bd_pins rpi_rx_0/isp_irq] [get_bd_pins concat_interrupts/In2]
  connect_bd_net -net rpi_rx_0_pll_lock_out [get_bd_pins rpi_rx_0/pll_lock_out] [get_bd_pins concat_leds/In0]
  connect_bd_net -net rpi_rx_0_vfbw_irq [get_bd_pins rpi_rx_0/vfbw_irq] [get_bd_pins concat_interrupts/In3]
  connect_bd_net -net video_rst_n_1 [get_bd_pins psr_250mhz/peripheral_aresetn] [get_bd_pins rpi_rx_0/video_rst_n] [get_bd_pins hdmi_tx_0/s_axis_video_aresetn]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins concat_leds/dout] [get_bd_ports led_out]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_1] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_AXI_NOC_1] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_0] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_1] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_1] [get_bd_addr_segs noc_mc_x1/S01_INI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_1] [get_bd_addr_segs noc_mc_x1/S01_INI/C1_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_2] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_2] [get_bd_addr_segs noc_mc_x1/S02_INI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_2] [get_bd_addr_segs noc_mc_x1/S02_INI/C2_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_3] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_3] [get_bd_addr_segs noc_mc_x1/S03_INI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/FPD_CCI_NOC_3] [get_bd_addr_segs noc_mc_x1/S03_INI/C3_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/LPD_AXI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/LPD_AXI_NOC_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0xA4020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA40C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs hdmi_tx_0/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40D0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs hdmi_tx_0/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/axi_iic_sen/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA5000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs axi_intc_parent/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/axigpiosen/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4010000 -range 0x00002000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/csirx_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA4000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs dummy_slave_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs gpio_resets/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40E0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs hdmi_tx_0/hdmiphy_ss/hdmi_gt_controller_0/axi4lite/Reg] -force
  assign_bd_address -offset 0xA4100000 -range 0x00020000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs hdmi_tx_0/v_hdmi_txss1_0/S_AXI_CPU_IN/Reg] -force
  assign_bd_address -offset 0xA40F0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs hdmi_tx_0/v_mix_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4040000 -range 0x00040000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/v_proc_csc_0/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA4030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces CIPS_0/M_AXI_FPD] [get_bd_addr_segs rpi_rx_0/vfbw/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces CIPS_0/PMC_NOC_AXI_0] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/PMC_NOC_AXI_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces CIPS_0/PMC_NOC_AXI_0] [get_bd_addr_segs noc_mc_x1/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces rpi_rx_0/vfbw/Data_m_axi_mm_video] [get_bd_addr_segs noc_mc_x1/S01_INI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces hdmi_tx_0/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs noc_mc_x1/S02_INI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces hdmi_tx_0/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs noc_mc_x1/S02_INI/C2_DDR_LOW1] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces rpi_rx_0/vfbw/Data_m_axi_mm_video] [get_bd_addr_segs noc_mc_x1/S01_INI/C1_DDR_LOW1]


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  #set_property PFM_NAME {xilinx.com:xd:vek280_base:202310.1} [get_files [current_bd_design].bd]
  set_property PFM_NAME {avnet.com:xd:ved2302_rpiRx_hdmiTx:202310.1} [get_files [current_bd_design].bd]
  set_property PFM.AXI_PORT {S10_AXI { memport "S_AXI_NOC" sptag "NOC_S10" } S11_AXI { memport "S_AXI_NOC" sptag "NOC_S11" } S12_AXI { memport "S_AXI_NOC" sptag "NOC_S12" } S13_AXI { memport "S_AXI_NOC" sptag "NOC_S13" } S14_AXI { memport "S_AXI_NOC" sptag "NOC_S14" } S15_AXI { memport "S_AXI_NOC" sptag "NOC_S15"} S16_AXI {memport "S_AXI_NOC" sptag "NOC_S16" } S17_AXI { memport "S_AXI_NOC" sptag "NOC_S17" } S18_AXI { memport "S_AXI_NOC" sptag "NOC_S18" } S19_AXI { memport "S_AXI_NOC" sptag "NOC_S19" } S20_AXI { memport "S_AXI_NOC" sptag "NOC_S20" } S21_AXI { memport "S_AXI_NOC" sptag "NOC_S21" } S22_AXI { memport "S_AXI_NOC" sptag "NOC_S22" } S23_AXI { memport "S_AXI_NOC" sptag "NOC_S23" } S24_AXI { memport "S_AXI_NOC" sptag "NOC_S24" } S25_AXI { memport "S_AXI_NOC" sptag "NOC_S25" } S26_AXI { memport "S_AXI_NOC" sptag "NOC_S26" } S27_AXI { memport "S_AXI_NOC" sptag "NOC_S27" } S28_AXI { memport "S_AXI_NOC" sptag "NOC_S28" } S29_AXI { memport "S_AXI_NOC" sptag "NOC_S29" } S30_AXI { memport "S_AXI_NOC" sptag "NOC_S30" } } [get_bd_cells /cips_noc]
  set_property PFM.IRQ {intr {id 0 range 32}} [get_bd_cells /axi_intc_parent]
  set_property PFM.CLOCK {clk_out1_100mhz {id "1" is_default "false" proc_sys_reset "/psr_100mhz" status "fixed" freq_hz "99999908"} clk_out2_150mhz {id "0" is_default "false" proc_sys_reset "/psr_150mhz" status "fixed" freq_hz "149999862"} clk_out3_300mhz {id "2" is_default "true" proc_sys_reset "/psr_300mhz" status "fixed" freq_hz "299999724"} clk_out4_250mhz {id "3" is_default "false" proc_sys_reset "/psr_250mhz" status "fixed" freq_hz "249999770"} clk_out5_200mhz {id "4" is_default "false" proc_sys_reset "/psr_200mhz" status "fixed" freq_hz "199999816"} clk_out6_400mhz {id "5" is_default "false" proc_sys_reset "/psr_400mhz" status "fixed" freq_hz "374999655"} clk_out7_600mhz {id "6" is_default "false" proc_sys_reset "/psr_600mhz" status "fixed" freq_hz "599999448"}} [get_bd_cells /clk_wizard_0]
  set_property PFM.AXI_PORT {M04_AXI { memport "M_AXI_GP" sptag "" memory "" } } [get_bd_cells /icn_ctrl_1]
  set_property PFM.AXI_PORT {M03_AXI { memport "M_AXI_GP" sptag "" memory "" } M04_AXI { memport "M_AXI_GP" sptag "" memory "" } M05_AXI { memport "M_AXI_GP" sptag "" memory "" } M06_AXI { memport "M_AXI_GP" sptag "" memory "" } M07_AXI { memport "M_AXI_GP" sptag "" memory "" } M08_AXI { memport "M_AXI_GP" sptag "" memory "" } M09_AXI { memport "M_AXI_GP" sptag "" memory "" } M10_AXI { memport "M_AXI_GP" sptag "" memory "" } M11_AXI { memport "M_AXI_GP" sptag "" memory "" } M12_AXI { memport "M_AXI_GP" sptag "" memory "" } M13_AXI { memport "M_AXI_GP" sptag "" memory "" } M14_AXI { memport "M_AXI_GP" sptag "" memory "" } M15_AXI { memport "M_AXI_GP" sptag "" memory "" } } [get_bd_cells /icn_ctrl_2]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


