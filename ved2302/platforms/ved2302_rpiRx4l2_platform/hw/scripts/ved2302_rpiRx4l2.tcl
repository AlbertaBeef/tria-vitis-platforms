
################################################################
# This is a generated script based on design: ved2302_rpiRx4l2
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
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "CRITICAL WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been changes to the IP between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the functionality and configuration of the design."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source ved2302_rpiRx4l2_script.tcl

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
set design_name ved2302_rpiRx4l2

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
xilinx.com:ip:axi_noc:*\
xilinx.com:ip:ai_engine:*\
xilinx.com:ip:smartconnect:*\
xilinx.com:ip:axi_gpio:*\
xilinx.com:ip:axi_iic:*\
xilinx.com:ip:axi_intc:*\
xilinx.com:ip:axi_vip:*\
xilinx.com:ip:clk_wizard:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:versal_cips:*\
xilinx.com:ip:xlconcat:*\
xilinx.com:ip:xlslice:*\
xilinx.com:hls:ISPPipeline_accel:*\
xilinx.com:ip:axis_data_fifo:*\
xilinx.com:ip:mipi_csi2_rx_subsystem:*\
xilinx.com:ip:v_proc_ss:*\
xilinx.com:ip:v_frmbuf_wr:*\
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


# Hierarchical cell: mipi_3
proc create_hier_cell_mipi_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 mipi_s_axi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 mm_video_scaled

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_gpio


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir I -type clk lite_aclk
  create_bd_pin -dir I -type rst lite_aresetn
  create_bd_pin -dir O -type intr vfbw_sc_irq
  create_bd_pin -dir I -type clk video_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MEMORY_TYPE {ultra} \
  ] $axis_data_fifo_0


  # Create instance: csirx_0, and set properties
  set csirx_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem csirx_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_NUM_PIXELS {1} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_BUF_DEPTH {4096} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
    CONFIG.C_DPHY_LANES {2} \
    CONFIG.C_EN_CSI_V2_0 {true} \
    CONFIG.C_HS_LINE_RATE {1500} \
    CONFIG.C_HS_SETTLE_NS {158} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {420} \
    CONFIG.SupportLevel {1} \
  ] $csirx_0


  # Create instance: smartconnect_mipi9, and set properties
  set smartconnect_mipi9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi9 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_mipi9


  # Create instance: v_proc_csc, and set properties
  set v_proc_csc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_csc ]
  set_property -dict [list \
    CONFIG.C_ENABLE_CSC {true} \
    CONFIG.C_MAX_COLS {1920} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_ROWS {1232} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_TOPOLOGY {0} \
  ] $v_proc_csc


  # Create instance: vfbw_scaled, and set properties
  set vfbw_scaled [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr vfbw_scaled ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {64} \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.HAS_UYVY8 {1} \
    CONFIG.HAS_Y8 {1} \
    CONFIG.HAS_YUV8 {1} \
    CONFIG.HAS_YUVX8 {1} \
    CONFIG.HAS_YUYV8 {1} \
    CONFIG.HAS_Y_UV8 {1} \
    CONFIG.HAS_Y_UV8_420 {0} \
    CONFIG.HAS_Y_U_V8 {0} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_NR_PLANES {2} \
    CONFIG.MAX_ROWS {1232} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $vfbw_scaled


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {12} \
    CONFIG.DIN_TO {12} \
  ] $xlslice_0


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {14} \
    CONFIG.DIN_TO {14} \
  ] $xlslice_2


  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {15} \
    CONFIG.DIN_TO {15} \
  ] $xlslice_3


  # Create instance: rpi_gpio, and set properties
  set rpi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio rpi_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $rpi_gpio


  # Create interface connections
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins v_proc_csc/s_axis] [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video]
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video2 [get_bd_intf_pins v_proc_csc/m_axis] [get_bd_intf_pins vfbw_scaled/s_axis_video]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video]
  connect_bd_intf_net -intf_net csirx_0_video_out [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins csirx_0/video_out]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_s_axi] [get_bd_intf_pins smartconnect_mipi9/S00_AXI]
  connect_bd_intf_net -intf_net frmbuf_wr_m_axi_mm_video [get_bd_intf_pins mm_video_scaled] [get_bd_intf_pins vfbw_scaled/m_axi_mm_video]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_pins mipi_phy_if_0] [get_bd_intf_pins csirx_0/mipi_phy_if]
  connect_bd_intf_net -intf_net rpi_gpio [get_bd_intf_pins rpi_gpio/GPIO] [get_bd_intf_pins rpi_gpio]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins csirx_0/csirxss_s_axi] [get_bd_intf_pins smartconnect_mipi9/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL] [get_bd_intf_pins smartconnect_mipi9/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_mipi9/M03_AXI] [get_bd_intf_pins vfbw_scaled/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_mipi9_M02_AXI [get_bd_intf_pins rpi_gpio/S_AXI] [get_bd_intf_pins smartconnect_mipi9/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi9_M04_AXI [get_bd_intf_pins smartconnect_mipi9/M04_AXI] [get_bd_intf_pins v_proc_csc/s_axi_ctrl]

  # Create port connections
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins lite_aclk] [get_bd_pins csirx_0/lite_aclk] [get_bd_pins smartconnect_mipi9/aclk] [get_bd_pins v_proc_csc/aclk_ctrl] [get_bd_pins rpi_gpio/s_axi_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins dphy_clk_200M] [get_bd_pins csirx_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_aclk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins csirx_0/video_aclk] [get_bd_pins smartconnect_mipi9/aclk1] [get_bd_pins v_proc_csc/aclk_axis] [get_bd_pins vfbw_scaled/ap_clk]
  connect_bd_net -net csi_rx_csirxss_csi_irq [get_bd_pins csirx_0/csirxss_csi_irq] [get_bd_pins csirxss_csi_irq]
  connect_bd_net -net frmbuf_wr_interrupt [get_bd_pins vfbw_scaled/interrupt] [get_bd_pins vfbw_sc_irq]
  connect_bd_net -net rst_clk_wizard_0_100M_peripheral_aresetn [get_bd_pins lite_aresetn] [get_bd_pins csirx_0/lite_aresetn] [get_bd_pins smartconnect_mipi9/aresetn] [get_bd_pins rpi_gpio/s_axi_aresetn]
  connect_bd_net -net rst_clk_wizard_0_300M_peripheral_aresetn [get_bd_pins video_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins csirx_0/video_aresetn]
  connect_bd_net -net versal_cips_0_LPD_GPIO_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins ISPPipeline_accel_0/ap_rst_n]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins v_proc_csc/aresetn_ctrl]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins xlslice_3/Dout] [get_bd_pins vfbw_scaled/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_2
proc create_hier_cell_mipi_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 mipi_s_axi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 mm_video_scaled

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_gpio


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I -type clk clkoutphy_in
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir I -type clk lite_aclk
  create_bd_pin -dir I -type rst lite_aresetn
  create_bd_pin -dir I pll_lock_in
  create_bd_pin -dir O -type intr vfbw_sc_irq
  create_bd_pin -dir I -type clk video_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MEMORY_TYPE {ultra} \
  ] $axis_data_fifo_0


  # Create instance: csirx_0, and set properties
  set csirx_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem csirx_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_NUM_PIXELS {1} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_BUF_DEPTH {4096} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
    CONFIG.C_DPHY_LANES {2} \
    CONFIG.C_EN_CSI_V2_0 {true} \
    CONFIG.C_HS_LINE_RATE {1500} \
    CONFIG.C_HS_SETTLE_NS {158} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {420} \
    CONFIG.SupportLevel {0} \
  ] $csirx_0


  # Create instance: smartconnect_mipi6, and set properties
  set smartconnect_mipi6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi6 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_mipi6


  # Create instance: v_proc_csc, and set properties
  set v_proc_csc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_csc ]
  set_property -dict [list \
    CONFIG.C_ENABLE_CSC {true} \
    CONFIG.C_MAX_COLS {1920} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_ROWS {1232} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_TOPOLOGY {0} \
  ] $v_proc_csc


  # Create instance: vfbw_scaled, and set properties
  set vfbw_scaled [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr vfbw_scaled ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {64} \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.HAS_UYVY8 {1} \
    CONFIG.HAS_Y8 {1} \
    CONFIG.HAS_YUV8 {1} \
    CONFIG.HAS_YUVX8 {1} \
    CONFIG.HAS_YUYV8 {1} \
    CONFIG.HAS_Y_UV8 {1} \
    CONFIG.HAS_Y_UV8_420 {0} \
    CONFIG.HAS_Y_U_V8 {0} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_NR_PLANES {2} \
    CONFIG.MAX_ROWS {1232} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $vfbw_scaled


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {8} \
    CONFIG.DIN_TO {8} \
  ] $xlslice_0


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {10} \
    CONFIG.DIN_TO {10} \
  ] $xlslice_2


  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {11} \
    CONFIG.DIN_TO {11} \
  ] $xlslice_3


  # Create instance: rpi_gpio, and set properties
  set rpi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio rpi_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $rpi_gpio


  # Create interface connections
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins v_proc_csc/s_axis] [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video]
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video2 [get_bd_intf_pins v_proc_csc/m_axis] [get_bd_intf_pins vfbw_scaled/s_axis_video]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video]
  connect_bd_intf_net -intf_net csirx_0_video_out [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins csirx_0/video_out]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_s_axi] [get_bd_intf_pins smartconnect_mipi6/S00_AXI]
  connect_bd_intf_net -intf_net frmbuf_wr_m_axi_mm_video [get_bd_intf_pins mm_video_scaled] [get_bd_intf_pins vfbw_scaled/m_axi_mm_video]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_pins mipi_phy_if_0] [get_bd_intf_pins csirx_0/mipi_phy_if]
  connect_bd_intf_net -intf_net rpi_gpio [get_bd_intf_pins rpi_gpio/GPIO] [get_bd_intf_pins rpi_gpio]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins csirx_0/csirxss_s_axi] [get_bd_intf_pins smartconnect_mipi6/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL] [get_bd_intf_pins smartconnect_mipi6/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_mipi6/M03_AXI] [get_bd_intf_pins vfbw_scaled/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_mipi5_M02_AXI [get_bd_intf_pins smartconnect_mipi6/M02_AXI] [get_bd_intf_pins rpi_gpio/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi5_M04_AXI [get_bd_intf_pins smartconnect_mipi6/M04_AXI] [get_bd_intf_pins v_proc_csc/s_axi_ctrl]

  # Create port connections
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins lite_aclk] [get_bd_pins csirx_0/lite_aclk] [get_bd_pins smartconnect_mipi6/aclk] [get_bd_pins v_proc_csc/aclk_ctrl] [get_bd_pins rpi_gpio/s_axi_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins dphy_clk_200M] [get_bd_pins csirx_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_aclk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins csirx_0/video_aclk] [get_bd_pins smartconnect_mipi6/aclk1] [get_bd_pins v_proc_csc/aclk_axis] [get_bd_pins vfbw_scaled/ap_clk]
  connect_bd_net -net clkoutphy_in_1 [get_bd_pins clkoutphy_in] [get_bd_pins csirx_0/clkoutphy_in]
  connect_bd_net -net csi_rx_csirxss_csi_irq [get_bd_pins csirx_0/csirxss_csi_irq] [get_bd_pins csirxss_csi_irq]
  connect_bd_net -net frmbuf_wr_interrupt [get_bd_pins vfbw_scaled/interrupt] [get_bd_pins vfbw_sc_irq]
  connect_bd_net -net pll_lock_in_1 [get_bd_pins pll_lock_in] [get_bd_pins csirx_0/pll_lock_in]
  connect_bd_net -net rst_clk_wizard_0_100M_peripheral_aresetn [get_bd_pins lite_aresetn] [get_bd_pins csirx_0/lite_aresetn] [get_bd_pins smartconnect_mipi6/aresetn] [get_bd_pins rpi_gpio/s_axi_aresetn]
  connect_bd_net -net rst_clk_wizard_0_300M_peripheral_aresetn [get_bd_pins video_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins csirx_0/video_aresetn]
  connect_bd_net -net versal_cips_0_LPD_GPIO_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins ISPPipeline_accel_0/ap_rst_n]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins v_proc_csc/aresetn_ctrl]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins xlslice_3/Dout] [get_bd_pins vfbw_scaled/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_1
proc create_hier_cell_mipi_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 mipi_s_axi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 mm_video_scaled

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_gpio


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I -type clk clkoutphy_in
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir I -type clk lite_aclk
  create_bd_pin -dir I -type rst lite_aresetn
  create_bd_pin -dir I pll_lock_in
  create_bd_pin -dir O -type intr vfbw_sc_irq
  create_bd_pin -dir I -type clk video_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MEMORY_TYPE {ultra} \
  ] $axis_data_fifo_0


  # Create instance: csirx_0, and set properties
  set csirx_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem csirx_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_NUM_PIXELS {1} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_BUF_DEPTH {4096} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
    CONFIG.C_DPHY_LANES {2} \
    CONFIG.C_EN_CSI_V2_0 {true} \
    CONFIG.C_HS_LINE_RATE {1500} \
    CONFIG.C_HS_SETTLE_NS {158} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {420} \
    CONFIG.SupportLevel {0} \
  ] $csirx_0


  # Create instance: smartconnect_mipi5, and set properties
  set smartconnect_mipi5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi5 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_mipi5


  # Create instance: v_proc_csc, and set properties
  set v_proc_csc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_csc ]
  set_property -dict [list \
    CONFIG.C_ENABLE_CSC {true} \
    CONFIG.C_MAX_COLS {1920} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_ROWS {1232} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_TOPOLOGY {0} \
  ] $v_proc_csc


  # Create instance: vfbw_scaled, and set properties
  set vfbw_scaled [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr vfbw_scaled ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {64} \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.HAS_UYVY8 {1} \
    CONFIG.HAS_Y8 {1} \
    CONFIG.HAS_YUV8 {1} \
    CONFIG.HAS_YUVX8 {1} \
    CONFIG.HAS_YUYV8 {1} \
    CONFIG.HAS_Y_UV8 {1} \
    CONFIG.HAS_Y_UV8_420 {0} \
    CONFIG.HAS_Y_U_V8 {0} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_NR_PLANES {2} \
    CONFIG.MAX_ROWS {1232} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $vfbw_scaled


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {4} \
    CONFIG.DIN_TO {4} \
  ] $xlslice_0


  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {6} \
    CONFIG.DIN_TO {6} \
  ] $xlslice_2


  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {7} \
    CONFIG.DIN_TO {7} \
  ] $xlslice_3


  # Create instance: rpi_gpio, and set properties
  set rpi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio rpi_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $rpi_gpio


  # Create interface connections
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins v_proc_csc/s_axis] [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video]
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video2 [get_bd_intf_pins v_proc_csc/m_axis] [get_bd_intf_pins vfbw_scaled/s_axis_video]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video]
  connect_bd_intf_net -intf_net csirx_0_video_out [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins csirx_0/video_out]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_s_axi] [get_bd_intf_pins smartconnect_mipi5/S00_AXI]
  connect_bd_intf_net -intf_net frmbuf_wr_m_axi_mm_video [get_bd_intf_pins mm_video_scaled] [get_bd_intf_pins vfbw_scaled/m_axi_mm_video]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_pins mipi_phy_if_0] [get_bd_intf_pins csirx_0/mipi_phy_if]
  connect_bd_intf_net -intf_net rpi_gpio [get_bd_intf_pins rpi_gpio/GPIO] [get_bd_intf_pins rpi_gpio]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins csirx_0/csirxss_s_axi] [get_bd_intf_pins smartconnect_mipi5/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL] [get_bd_intf_pins smartconnect_mipi5/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_mipi5/M03_AXI] [get_bd_intf_pins vfbw_scaled/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_mipi5_M02_AXI [get_bd_intf_pins smartconnect_mipi5/M02_AXI] [get_bd_intf_pins rpi_gpio/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi5_M04_AXI [get_bd_intf_pins smartconnect_mipi5/M04_AXI] [get_bd_intf_pins v_proc_csc/s_axi_ctrl]

  # Create port connections
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins lite_aclk] [get_bd_pins csirx_0/lite_aclk] [get_bd_pins smartconnect_mipi5/aclk] [get_bd_pins v_proc_csc/aclk_ctrl] [get_bd_pins rpi_gpio/s_axi_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins dphy_clk_200M] [get_bd_pins csirx_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_aclk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins csirx_0/video_aclk] [get_bd_pins smartconnect_mipi5/aclk1] [get_bd_pins v_proc_csc/aclk_axis] [get_bd_pins vfbw_scaled/ap_clk]
  connect_bd_net -net clkoutphy_in_1 [get_bd_pins clkoutphy_in] [get_bd_pins csirx_0/clkoutphy_in]
  connect_bd_net -net csi_rx_csirxss_csi_irq [get_bd_pins csirx_0/csirxss_csi_irq] [get_bd_pins csirxss_csi_irq]
  connect_bd_net -net frmbuf_wr_interrupt [get_bd_pins vfbw_scaled/interrupt] [get_bd_pins vfbw_sc_irq]
  connect_bd_net -net pll_lock_in_1 [get_bd_pins pll_lock_in] [get_bd_pins csirx_0/pll_lock_in]
  connect_bd_net -net rst_clk_wizard_0_100M_peripheral_aresetn [get_bd_pins lite_aresetn] [get_bd_pins csirx_0/lite_aresetn] [get_bd_pins smartconnect_mipi5/aresetn] [get_bd_pins rpi_gpio/s_axi_aresetn]
  connect_bd_net -net rst_clk_wizard_0_300M_peripheral_aresetn [get_bd_pins video_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins csirx_0/video_aresetn]
  connect_bd_net -net versal_cips_0_LPD_GPIO_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins ISPPipeline_accel_0/ap_rst_n]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins v_proc_csc/aresetn_ctrl]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins xlslice_3/Dout] [get_bd_pins vfbw_scaled/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_0
proc create_hier_cell_mipi_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mipi_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 mipi_s_axi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 mm_video_scaled

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_gpio


  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -type clk clkoutphy_out
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir I -type clk lite_aclk
  create_bd_pin -dir I -type rst lite_aresetn
  create_bd_pin -dir O pll_lock_out
  create_bd_pin -dir O -type intr vfbw_sc_irq
  create_bd_pin -dir I -type clk video_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: ISPPipeline_accel_0, and set properties
  set ISPPipeline_accel_0 [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel ISPPipeline_accel_0 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {4096} \
    CONFIG.FIFO_MEMORY_TYPE {ultra} \
  ] $axis_data_fifo_0


  # Create instance: csirx_0, and set properties
  set csirx_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem csirx_0 ]
  set_property -dict [list \
    CONFIG.CMN_NUM_LANES {2} \
    CONFIG.CMN_NUM_PIXELS {1} \
    CONFIG.CMN_PXL_FORMAT {RAW10} \
    CONFIG.CSI_BUF_DEPTH {4096} \
    CONFIG.C_CSI_EN_ACTIVELANES {true} \
    CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
    CONFIG.C_DPHY_LANES {2} \
    CONFIG.C_EN_CSI_V2_0 {true} \
    CONFIG.C_HS_LINE_RATE {1500} \
    CONFIG.C_HS_SETTLE_NS {158} \
    CONFIG.DPY_EN_REG_IF {true} \
    CONFIG.DPY_LINE_RATE {420} \
    CONFIG.SupportLevel {1} \
  ] $csirx_0


  # Create instance: smartconnect_mipi2, and set properties
  set smartconnect_mipi2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi2 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_mipi2


  # Create instance: v_proc_csc, and set properties
  set v_proc_csc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_csc ]
  set_property -dict [list \
    CONFIG.C_ENABLE_CSC {true} \
    CONFIG.C_MAX_COLS {1920} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_ROWS {1232} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_TOPOLOGY {0} \
  ] $v_proc_csc


  # Create instance: vfbw_scaled, and set properties
  set vfbw_scaled [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr vfbw_scaled ]
  set_property -dict [list \
    CONFIG.AXIMM_ADDR_WIDTH {64} \
    CONFIG.HAS_BGR8 {1} \
    CONFIG.HAS_BGRX8 {1} \
    CONFIG.HAS_RGBX8 {1} \
    CONFIG.HAS_UYVY8 {1} \
    CONFIG.HAS_Y8 {1} \
    CONFIG.HAS_YUV8 {1} \
    CONFIG.HAS_YUVX8 {1} \
    CONFIG.HAS_YUYV8 {1} \
    CONFIG.HAS_Y_UV8 {1} \
    CONFIG.HAS_Y_UV8_420 {0} \
    CONFIG.HAS_Y_U_V8 {0} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_NR_PLANES {2} \
    CONFIG.MAX_ROWS {1232} \
    CONFIG.SAMPLES_PER_CLOCK {1} \
  ] $vfbw_scaled


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_2 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {2} \
    CONFIG.DIN_TO {2} \
  ] $xlslice_2


  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_3 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {3} \
    CONFIG.DIN_TO {3} \
  ] $xlslice_3


  # Create instance: rpi_gpio, and set properties
  set rpi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio rpi_gpio ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {2} \
  ] $rpi_gpio


  # Create interface connections
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video [get_bd_intf_pins v_proc_csc/s_axis] [get_bd_intf_pins ISPPipeline_accel_0/m_axis_video]
  connect_bd_intf_net -intf_net ISPPipeline_accel_0_m_axis_video2 [get_bd_intf_pins v_proc_csc/m_axis] [get_bd_intf_pins vfbw_scaled/s_axis_video]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins ISPPipeline_accel_0/s_axis_video]
  connect_bd_intf_net -intf_net csirx_0_video_out [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins csirx_0/video_out]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_s_axi] [get_bd_intf_pins smartconnect_mipi2/S00_AXI]
  connect_bd_intf_net -intf_net frmbuf_wr_m_axi_mm_video [get_bd_intf_pins mm_video_scaled] [get_bd_intf_pins vfbw_scaled/m_axi_mm_video]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_pins mipi_phy_if_0] [get_bd_intf_pins csirx_0/mipi_phy_if]
  connect_bd_intf_net -intf_net rpi_gpio [get_bd_intf_pins rpi_gpio/GPIO] [get_bd_intf_pins rpi_gpio]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins csirx_0/csirxss_s_axi] [get_bd_intf_pins smartconnect_mipi2/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins ISPPipeline_accel_0/s_axi_CTRL] [get_bd_intf_pins smartconnect_mipi2/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_mipi2/M03_AXI] [get_bd_intf_pins vfbw_scaled/s_axi_CTRL]
  connect_bd_intf_net -intf_net smartconnect_mipi2_M02_AXI [get_bd_intf_pins smartconnect_mipi2/M02_AXI] [get_bd_intf_pins rpi_gpio/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi2_M04_AXI [get_bd_intf_pins smartconnect_mipi2/M04_AXI] [get_bd_intf_pins v_proc_csc/s_axi_ctrl]

  # Create port connections
  connect_bd_net -net clk_wizard_0_clk_out1 [get_bd_pins lite_aclk] [get_bd_pins csirx_0/lite_aclk] [get_bd_pins smartconnect_mipi2/aclk] [get_bd_pins v_proc_csc/aclk_ctrl] [get_bd_pins rpi_gpio/s_axi_aclk]
  connect_bd_net -net clk_wizard_0_clk_out2 [get_bd_pins dphy_clk_200M] [get_bd_pins csirx_0/dphy_clk_200M]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins video_aclk] [get_bd_pins ISPPipeline_accel_0/ap_clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins csirx_0/video_aclk] [get_bd_pins smartconnect_mipi2/aclk1] [get_bd_pins v_proc_csc/aclk_axis] [get_bd_pins vfbw_scaled/ap_clk]
  connect_bd_net -net csi_rx_csirxss_csi_irq [get_bd_pins csirx_0/csirxss_csi_irq] [get_bd_pins csirxss_csi_irq]
  connect_bd_net -net csirx_0_clkoutphy_out [get_bd_pins csirx_0/clkoutphy_out] [get_bd_pins clkoutphy_out]
  connect_bd_net -net csirx_0_pll_lock_out [get_bd_pins csirx_0/pll_lock_out] [get_bd_pins pll_lock_out]
  connect_bd_net -net frmbuf_wr_interrupt [get_bd_pins vfbw_scaled/interrupt] [get_bd_pins vfbw_sc_irq]
  connect_bd_net -net rst_clk_wizard_0_100M_peripheral_aresetn [get_bd_pins lite_aresetn] [get_bd_pins csirx_0/lite_aresetn] [get_bd_pins smartconnect_mipi2/aresetn] [get_bd_pins rpi_gpio/s_axi_aresetn]
  connect_bd_net -net rst_clk_wizard_0_300M_peripheral_aresetn [get_bd_pins video_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins csirx_0/video_aresetn]
  connect_bd_net -net versal_cips_0_LPD_GPIO_o [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins xlslice_0/Dout] [get_bd_pins ISPPipeline_accel_0/ap_rst_n]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins xlslice_2/Dout] [get_bd_pins v_proc_csc/aresetn_ctrl]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins xlslice_3/Dout] [get_bd_pins vfbw_scaled/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: cips_ss_0
proc create_hier_cell_cips_ss_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_cips_ss_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FPD_CCI_NOC_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FPD_CCI_NOC_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FPD_CCI_NOC_2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FPD_CCI_NOC_3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 LPD_AXI_NOC_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 PMC_NOC_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 In0
  create_bd_pin -dir I -from 0 -to 0 In1
  create_bd_pin -dir I -from 0 -to 0 In2
  create_bd_pin -dir I -from 0 -to 0 In3
  create_bd_pin -dir I -from 0 -to 0 In4
  create_bd_pin -dir I -from 0 -to 0 In5
  create_bd_pin -dir I -from 0 -to 0 In6
  create_bd_pin -dir I -from 0 -to 0 In7
  create_bd_pin -dir I -from 0 -to 0 In8
  create_bd_pin -dir O -type clk clk2_300M
  create_bd_pin -dir O -type clk clk_200M
  create_bd_pin -dir O -type clk clk_250M
  create_bd_pin -dir I -type intr fbrd_irq2
  create_bd_pin -dir O -type clk fpd_cci_noc_axi0_clk
  create_bd_pin -dir O -type clk fpd_cci_noc_axi1_clk
  create_bd_pin -dir O -type clk fpd_cci_noc_axi2_clk
  create_bd_pin -dir O -type clk fpd_cci_noc_axi3_clk
  create_bd_pin -dir O -type clk frl_clk
  create_bd_pin -dir O -from 31 -to 0 gpio_io_o
  create_bd_pin -dir I hdmi_tx_irq4
  create_bd_pin -dir O -type clk lpd_axi_noc_clk
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn2_300M
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn_100M
  create_bd_pin -dir O -from 0 -to 0 peripheral_aresetn_250M
  create_bd_pin -dir O -type clk pmc_axi_noc_axi0_clk
  create_bd_pin -dir O -from 0 -to 0 rx_en
  create_bd_pin -dir O -type clk s_axi_aclk
  create_bd_pin -dir I vphy_irq5

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_1 ]
  set_property -dict [list \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_DOUT_DEFAULT {0xFFFFFFFF} \
  ] $axi_gpio_1


  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_2 ]
  set_property CONFIG.C_ALL_OUTPUTS {1} $axi_gpio_2


  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc_0 ]
  set_property CONFIG.C_IRQ_CONNECTION {1} $axi_intc_0


  # Create instance: axi_intc_parent, and set properties
  set axi_intc_parent [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc_parent ]
  set_property CONFIG.C_IRQ_CONNECTION {1} $axi_intc_parent


  # Create instance: axi_vip_0, and set properties
  set axi_vip_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip axi_vip_0 ]
  set_property CONFIG.INTERFACE_MODE {SLAVE} $axi_vip_0


  # Create instance: axi_vip_1, and set properties
  set axi_vip_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vip axi_vip_1 ]
  set_property -dict [list \
    CONFIG.ADDR_WIDTH {32} \
    CONFIG.ARUSER_WIDTH {0} \
    CONFIG.AWUSER_WIDTH {0} \
    CONFIG.BUSER_WIDTH {0} \
    CONFIG.DATA_WIDTH {32} \
    CONFIG.HAS_BRESP {1} \
    CONFIG.HAS_BURST {1} \
    CONFIG.HAS_CACHE {1} \
    CONFIG.HAS_LOCK {1} \
    CONFIG.HAS_PROT {1} \
    CONFIG.HAS_QOS {1} \
    CONFIG.HAS_REGION {1} \
    CONFIG.HAS_RRESP {1} \
    CONFIG.HAS_WSTRB {1} \
    CONFIG.ID_WIDTH {0} \
    CONFIG.INTERFACE_MODE {MASTER} \
    CONFIG.PROTOCOL {AXI4} \
    CONFIG.READ_WRITE_MODE {READ_WRITE} \
    CONFIG.RUSER_WIDTH {0} \
    CONFIG.SUPPORTS_NARROW {1} \
    CONFIG.WUSER_WIDTH {0} \
  ] $axi_vip_1


  # Create instance: clk_wizard_0, and set properties
  set clk_wizard_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard clk_wizard_0 ]
  set_property -dict [list \
    CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
    CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
    CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
    CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
    CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
    CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
    CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {325,300,300.000,100.000,100.000,100.000,100.000} \
    CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
    CONFIG.CLKOUT_USED {true,true,false,false,false,false,false} \
    CONFIG.PRIM_SOURCE {No_buffer} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_RESET {true} \
  ] $clk_wizard_0


  # Create instance: clk_wizard_1, and set properties
  set clk_wizard_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wizard clk_wizard_1 ]
  set_property -dict [list \
    CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG} \
    CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None} \
    CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto} \
    CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false} \
    CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7} \
    CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000} \
    CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {200,250,250.000,300.000,150.000,100.000,100.000} \
    CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000} \
    CONFIG.CLKOUT_USED {true,true,true,true,true,false,false} \
    CONFIG.PRIM_SOURCE {No_buffer} \
    CONFIG.RESET_TYPE {ACTIVE_LOW} \
    CONFIG.USE_LOCKED {true} \
    CONFIG.USE_RESET {true} \
  ] $clk_wizard_1


  # Create instance: rst_processor_150M_DPU, and set properties
  set rst_processor_150M_DPU [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_150M_DPU ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_150M_DPU


  # Create instance: rst_processor_1_100M, and set properties
  set rst_processor_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_1_100M ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_1_100M


  # Create instance: rst_processor_1_250M, and set properties
  set rst_processor_1_250M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_1_250M ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_1_250M


  # Create instance: rst_processor_1_300M, and set properties
  set rst_processor_1_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_1_300M ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_1_300M


  # Create instance: rst_processor_250M_DPU, and set properties
  set rst_processor_250M_DPU [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_250M_DPU ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_250M_DPU


  # Create instance: rst_processor_300M_DPU, and set properties
  set rst_processor_300M_DPU [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processor_300M_DPU ]
  set_property CONFIG.C_NUM_INTERCONNECT_ARESETN {1} $rst_processor_300M_DPU


  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {3} \
    CONFIG.NUM_MI {14} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_0


  # Create instance: smartconnect_1, and set properties
  set smartconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_1 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_SI {1} \
  ] $smartconnect_1


  # Create instance: versal_cips, and set properties
  set versal_cips [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips versal_cips ]
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
      PMC_SD0_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x3} {CLK_200_SDR_OTAP_DLY 0x2} {CLK_50_DDR_ITAP_DLY 0x36} {CLK_50_DDR_OTAP_DLY 0x3} {CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x4} {ENABLE 1} {IO\
{PMC_MIO 37 .. 49}}} \
      PMC_SD0_SLOT_TYPE {SD 3.0} \
      PMC_SD1_DATA_TRANSFER_MODE {8Bit} \
      PMC_SD1_PERIPHERAL {{CLK_100_SDR_OTAP_DLY 0x00} {CLK_200_SDR_OTAP_DLY 0x2} {CLK_50_DDR_ITAP_DLY 0x1E} {CLK_50_DDR_OTAP_DLY 0x5} {CLK_50_SDR_ITAP_DLY 0x2C} {CLK_50_SDR_OTAP_DLY 0x5} {ENABLE 1} {IO\
{PMC_MIO 26 .. 36}}} \
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
      PS_I2C1_PERIPHERAL {{ENABLE 0} {IO {PS_MIO 0 .. 1}}} \
      PS_IRQ_USAGE {{CH0 1} {CH1 1} {CH10 0} {CH11 0} {CH12 0} {CH13 0} {CH14 0} {CH15 0} {CH2 1} {CH3 1} {CH4 1} {CH5 1} {CH6 1} {CH7 1} {CH8 0} {CH9 0}} \
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
      PS_USE_FPD_AXI_NOC0 {0} \
      PS_USE_FPD_AXI_NOC1 {0} \
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
  ] $versal_cips


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {9} $xlconcat_0


  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_1 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {19} \
    CONFIG.DIN_TO {19} \
  ] $xlslice_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_vip_1/M_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins FPD_CCI_NOC_0] [get_bd_intf_pins versal_cips/FPD_CCI_NOC_0]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins FPD_CCI_NOC_1] [get_bd_intf_pins versal_cips/FPD_CCI_NOC_1]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins FPD_CCI_NOC_2] [get_bd_intf_pins versal_cips/FPD_CCI_NOC_2]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins M01_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins smartconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins M11_AXI] [get_bd_intf_pins smartconnect_0/M11_AXI]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins FPD_CCI_NOC_3] [get_bd_intf_pins versal_cips/FPD_CCI_NOC_3]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins LPD_AXI_NOC_0] [get_bd_intf_pins versal_cips/LPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins PMC_NOC_AXI_0] [get_bd_intf_pins versal_cips/PMC_NOC_AXI_0]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins axi_intc_parent/s_axi] [get_bd_intf_pins smartconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins axi_gpio_1/S_AXI] [get_bd_intf_pins smartconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M05_AXI [get_bd_intf_pins M05_AXI] [get_bd_intf_pins smartconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M07_AXI [get_bd_intf_pins M07_AXI] [get_bd_intf_pins smartconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M08_AXI [get_bd_intf_pins axi_gpio_2/S_AXI] [get_bd_intf_pins smartconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M09_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins smartconnect_0/M09_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M10_AXI [get_bd_intf_pins M10_AXI] [get_bd_intf_pins smartconnect_0/M10_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M12_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins smartconnect_0/M12_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M13_AXI [get_bd_intf_pins smartconnect_1/S00_AXI] [get_bd_intf_pins smartconnect_0/M13_AXI]
  connect_bd_intf_net -intf_net smartconnect_1_M00_AXI [get_bd_intf_pins axi_vip_0/S_AXI] [get_bd_intf_pins smartconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net versal_cips_M_AXI_FPD [get_bd_intf_pins smartconnect_0/S00_AXI] [get_bd_intf_pins versal_cips/M_AXI_FPD]

  # Create port connections
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net In3_1 [get_bd_pins In3] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net In4_1 [get_bd_pins In4] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net In5_1 [get_bd_pins In5] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net In6_1 [get_bd_pins In6] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net In7_1 [get_bd_pins In7] [get_bd_pins xlconcat_0/In7]
  connect_bd_net -net In8_1 [get_bd_pins In8] [get_bd_pins xlconcat_0/In8]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_2/gpio_io_o] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net axi_gpio_1_gpio_io_o [get_bd_pins axi_gpio_1/gpio_io_o] [get_bd_pins gpio_io_o]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins versal_cips/pl_ps_irq6]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins versal_cips/pl_ps_irq3]
  connect_bd_net -net axi_intc_parent_irq [get_bd_pins axi_intc_parent/irq] [get_bd_pins versal_cips/pl_ps_irq7]
  connect_bd_net -net clk_wizard_0_clk_out3 [get_bd_pins clk_wizard_0/clk_out2] [get_bd_pins clk2_300M] [get_bd_pins rst_processor_1_300M/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk2]
  connect_bd_net -net clk_wizard_1_clk_out1 [get_bd_pins clk_wizard_1/clk_out1] [get_bd_pins clk_200M]
  connect_bd_net -net clk_wizard_1_clk_out3 [get_bd_pins clk_wizard_1/clk_out3] [get_bd_pins axi_vip_0/aclk] [get_bd_pins rst_processor_250M_DPU/slowest_sync_clk] [get_bd_pins smartconnect_1/aclk1]
  connect_bd_net -net clk_wizard_1_clk_out4 [get_bd_pins clk_wizard_1/clk_out4] [get_bd_pins rst_processor_300M_DPU/slowest_sync_clk]
  connect_bd_net -net clk_wizard_1_clk_out5 [get_bd_pins clk_wizard_1/clk_out5] [get_bd_pins rst_processor_150M_DPU/slowest_sync_clk]
  connect_bd_net -net clk_wizard_1_locked [get_bd_pins clk_wizard_1/locked] [get_bd_pins rst_processor_150M_DPU/aux_reset_in] [get_bd_pins rst_processor_150M_DPU/dcm_locked] [get_bd_pins rst_processor_150M_DPU/ext_reset_in] [get_bd_pins rst_processor_1_250M/aux_reset_in] [get_bd_pins rst_processor_1_250M/dcm_locked] [get_bd_pins rst_processor_1_250M/ext_reset_in] [get_bd_pins rst_processor_250M_DPU/aux_reset_in] [get_bd_pins rst_processor_250M_DPU/dcm_locked] [get_bd_pins rst_processor_250M_DPU/ext_reset_in] [get_bd_pins rst_processor_300M_DPU/aux_reset_in] [get_bd_pins rst_processor_300M_DPU/dcm_locked] [get_bd_pins rst_processor_300M_DPU/ext_reset_in]
  connect_bd_net -net fbrd_irq2_1 [get_bd_pins fbrd_irq2] [get_bd_pins versal_cips/pl_ps_irq2]
  connect_bd_net -net hdmi_tx_irq4_1 [get_bd_pins hdmi_tx_irq4] [get_bd_pins versal_cips/pl_ps_irq4]
  connect_bd_net -net net_clk_wizard_0_clk_out1 [get_bd_pins clk_wizard_0/clk_out1] [get_bd_pins frl_clk]
  connect_bd_net -net net_clk_wizard_0_clk_out2 [get_bd_pins clk_wizard_1/clk_out2] [get_bd_pins clk_250M] [get_bd_pins axi_gpio_1/s_axi_aclk] [get_bd_pins rst_processor_1_250M/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk1]
  connect_bd_net -net net_clk_wizard_0_locked [get_bd_pins clk_wizard_0/locked] [get_bd_pins rst_processor_1_300M/aux_reset_in] [get_bd_pins rst_processor_1_300M/dcm_locked] [get_bd_pins rst_processor_1_300M/ext_reset_in]
  connect_bd_net -net net_rst_processor_1_100M_interconnect_aresetn [get_bd_pins rst_processor_1_100M/interconnect_aresetn] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_intc_parent/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins smartconnect_1/aresetn]
  connect_bd_net -net net_rst_processor_1_100M_peripheral_aresetn [get_bd_pins rst_processor_1_100M/peripheral_aresetn] [get_bd_pins peripheral_aresetn_100M] [get_bd_pins axi_gpio_2/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_vip_1/aresetn]
  connect_bd_net -net net_rst_processor_1_300M_peripheral_aresetn [get_bd_pins rst_processor_1_250M/peripheral_aresetn] [get_bd_pins peripheral_aresetn_250M] [get_bd_pins axi_gpio_1/s_axi_aresetn]
  connect_bd_net -net net_versal_cips_pl0_ref_clk [get_bd_pins versal_cips/pl0_ref_clk] [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_intc_parent/s_axi_aclk] [get_bd_pins axi_vip_1/aclk] [get_bd_pins clk_wizard_0/clk_in1] [get_bd_pins clk_wizard_1/clk_in1] [get_bd_pins rst_processor_1_100M/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins smartconnect_1/aclk] [get_bd_pins versal_cips/m_axi_fpd_aclk]
  connect_bd_net -net net_versal_cips_pl0_resetn [get_bd_pins versal_cips/pl0_resetn] [get_bd_pins clk_wizard_0/resetn] [get_bd_pins clk_wizard_1/resetn] [get_bd_pins rst_processor_1_100M/aux_reset_in] [get_bd_pins rst_processor_1_100M/dcm_locked] [get_bd_pins rst_processor_1_100M/ext_reset_in]
  connect_bd_net -net rst_processor_250M_DPU_peripheral_aresetn [get_bd_pins rst_processor_250M_DPU/peripheral_aresetn] [get_bd_pins axi_vip_0/aresetn]
  connect_bd_net -net rst_processor_2_300M_peripheral_aresetn [get_bd_pins rst_processor_1_300M/peripheral_aresetn] [get_bd_pins peripheral_aresetn2_300M]
  connect_bd_net -net versal_cips_fpd_cci_noc_axi0_clk [get_bd_pins versal_cips/fpd_cci_noc_axi0_clk] [get_bd_pins fpd_cci_noc_axi0_clk]
  connect_bd_net -net versal_cips_fpd_cci_noc_axi1_clk [get_bd_pins versal_cips/fpd_cci_noc_axi1_clk] [get_bd_pins fpd_cci_noc_axi1_clk]
  connect_bd_net -net versal_cips_fpd_cci_noc_axi2_clk [get_bd_pins versal_cips/fpd_cci_noc_axi2_clk] [get_bd_pins fpd_cci_noc_axi2_clk]
  connect_bd_net -net versal_cips_fpd_cci_noc_axi3_clk [get_bd_pins versal_cips/fpd_cci_noc_axi3_clk] [get_bd_pins fpd_cci_noc_axi3_clk]
  connect_bd_net -net versal_cips_lpd_axi_noc_clk [get_bd_pins versal_cips/lpd_axi_noc_clk] [get_bd_pins lpd_axi_noc_clk]
  connect_bd_net -net versal_cips_pmc_axi_noc_axi0_clk [get_bd_pins versal_cips/pmc_axi_noc_axi0_clk] [get_bd_pins pmc_axi_noc_axi0_clk]
  connect_bd_net -net vphy_irq5_1 [get_bd_pins vphy_irq5] [get_bd_pins versal_cips/pl_ps_irq5]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xlconcat_0/dout] [get_bd_pins axi_intc_parent/intr]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins xlslice_1/Dout] [get_bd_pins rx_en]

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
  set HDMI_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTRL ]

  set ch0_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch0_lpddr4_trip1 ]

  set ch1_lpddr4_trip1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:lpddr4_rtl:1.0 ch1_lpddr4_trip1 ]

  set lpddr4_clk1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 lpddr4_clk1 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $lpddr4_clk1

  set rpi_rx_0_mipi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 rpi_rx_0_mipi ]

  set rpi_rx_1_mipi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 rpi_rx_1_mipi ]

  set rpi_rx_3_mipi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 rpi_rx_3_mipi ]

  set rpi_rx_0_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_rx_0_gpio ]

  set rpi_rx_1_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_rx_1_gpio ]

  set rpi_rx_3_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_rx_3_gpio ]

  set rpi_rx_2_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rpi_rx_2_gpio ]

  set rpi_rx_2_mipi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 rpi_rx_2_mipi ]


  # Create ports
  set TX_HPD_IN [ create_bd_port -dir I TX_HPD_IN ]
  set rx_en [ create_bd_port -dir O -from 0 -to 0 rx_en ]
  set tx_en [ create_bd_port -dir O -from 0 -to 0 tx_en ]

  # Create instance: ConfigNoc, and set properties
  set ConfigNoc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc ConfigNoc ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {6} \
    CONFIG.NUM_MI {5} \
    CONFIG.NUM_NSI {1} \
  ] $ConfigNoc


  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M00_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M01_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M02_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M03_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {aie} \
 ] [get_bd_intf_pins /ConfigNoc/M04_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M03_AXI {read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M04_AXI {read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M01_AXI {read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M02_AXI {read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}} M00_AXI {read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}}} \
   CONFIG.DEST_IDS {M03_AXI:0x1c0:M04_AXI:0x140:M01_AXI:0x200:M02_AXI:0x180:M00_AXI:0x240} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /ConfigNoc/S00_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_AXI { read_bw {128} write_bw {128} read_avg_burst {4} write_avg_burst {4}}} \
 ] [get_bd_intf_pins /ConfigNoc/S00_INI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M00_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M01_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M02_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M03_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M04_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /ConfigNoc/aclk5]

  # Create instance: ai_engine_0, and set properties
  set ai_engine_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ai_engine ai_engine_0 ]
  set_property -dict [list \
    CONFIG.CLK_NAMES {} \
    CONFIG.FIFO_TYPE_MI_AXIS {} \
    CONFIG.FIFO_TYPE_SI_AXIS {} \
    CONFIG.NAME_MI_AXIS {} \
    CONFIG.NAME_SI_AXIS {} \
    CONFIG.NUM_CLKS {0} \
    CONFIG.NUM_MI_AXI {0} \
    CONFIG.NUM_MI_AXIS {0} \
    CONFIG.NUM_SI_AXI {5} \
    CONFIG.NUM_SI_AXIS {0} \
  ] $ai_engine_0


  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S00_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S01_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S02_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S03_AXI]

  set_property -dict [ list \
   CONFIG.CATEGORY {NOC} \
 ] [get_bd_intf_pins /ai_engine_0/S04_AXI]

  # Create instance: cips_noc, and set properties
  set cips_noc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc cips_noc ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {8} \
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
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.CONNECTIONS {M04_INI {read_bw {128} write_bw {128}} M00_INI {read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S00_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M01_INI {read_bw {128} write_bw {128}} M04_INI {read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S01_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M02_INI {read_bw {128} write_bw {128}} M04_INI {read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S02_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M03_INI {read_bw {128} write_bw {128}} M04_INI {read_bw {128} write_bw {128}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_cci} \
 ] [get_bd_intf_pins /cips_noc/S03_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M00_INI {read_bw {5} write_bw {5}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_rpu} \
 ] [get_bd_intf_pins /cips_noc/S04_AXI]

  set_property -dict [ list \
   CONFIG.CONNECTIONS {M04_INI {read_bw {5} write_bw {5}} M00_INI {read_bw {5} write_bw {5}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {ps_pmc} \
 ] [get_bd_intf_pins /cips_noc/S05_AXI]

  set_property -dict [ list \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.CONNECTIONS {M01_INI {read_bw {512} write_bw {1024} read_avg_burst {32} write_avg_burst {32}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S06_AXI]

  set_property -dict [ list \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.CONNECTIONS {M02_INI {read_bw {512} write_bw {1024} read_avg_burst {32} write_avg_burst {32}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S07_AXI]

  set_property -dict [ list \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.CONNECTIONS {M03_INI {read_bw {512} write_bw {1024} read_avg_burst {32} write_avg_burst {32}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S08_AXI]

  set_property -dict [ list \
   CONFIG.R_TRAFFIC_CLASS {LOW_LATENCY} \
   CONFIG.W_TRAFFIC_CLASS {BEST_EFFORT} \
   CONFIG.CONNECTIONS {M00_INI {read_bw {512} write_bw {1024} read_avg_burst {32} write_avg_burst {32}}} \
   CONFIG.DEST_IDS {} \
   CONFIG.NOC_PARAMS {} \
   CONFIG.CATEGORY {pl} \
 ] [get_bd_intf_pins /cips_noc/S09_AXI]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S00_AXI} \
 ] [get_bd_pins /cips_noc/aclk0]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S01_AXI} \
 ] [get_bd_pins /cips_noc/aclk1]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S02_AXI} \
 ] [get_bd_pins /cips_noc/aclk2]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S03_AXI} \
 ] [get_bd_pins /cips_noc/aclk3]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S05_AXI} \
 ] [get_bd_pins /cips_noc/aclk4]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S06_AXI:S07_AXI:S08_AXI:S09_AXI} \
 ] [get_bd_pins /cips_noc/aclk5]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {} \
 ] [get_bd_pins /cips_noc/aclk6]

  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S04_AXI} \
 ] [get_bd_pins /cips_noc/aclk7]

  # Create instance: cips_ss_0
  create_hier_cell_cips_ss_0 [current_bd_instance .] cips_ss_0

  # Create instance: mipi_0
  create_hier_cell_mipi_0 [current_bd_instance .] mipi_0

  # Create instance: mipi_1
  create_hier_cell_mipi_1 [current_bd_instance .] mipi_1

  # Create instance: noc_ddr4, and set properties
  set noc_ddr4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_noc noc_ddr4 ]
  set_property -dict [list \
    CONFIG.CH0_LPDDR4_0_BOARD_INTERFACE {ch0_lpddr4_trip1} \
    CONFIG.CH1_LPDDR4_0_BOARD_INTERFACE {ch1_lpddr4_trip1} \
    CONFIG.MC_CHANNEL_INTERLEAVING {true} \
    CONFIG.MC_CHAN_REGION0 {DDR_LOW0} \
    CONFIG.MC_CHAN_REGION1 {DDR_LOW1} \
    CONFIG.MC_CH_INTERLEAVING_SIZE {256_Bytes} \
    CONFIG.MC_LP4_OVERWRITE_IO_PROP {true} \
    CONFIG.NUM_CLKS {0} \
    CONFIG.NUM_MC {1} \
    CONFIG.NUM_MCP {4} \
    CONFIG.NUM_MI {0} \
    CONFIG.NUM_NSI {4} \
    CONFIG.NUM_SI {0} \
    CONFIG.sys_clk0_BOARD_INTERFACE {lpddr4_clk1} \
  ] $noc_ddr4


  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_0 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_ddr4/S00_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_1 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_ddr4/S01_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_2 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_ddr4/S02_INI]

  set_property -dict [ list \
   CONFIG.INI_STRATEGY {auto} \
   CONFIG.CONNECTIONS {MC_3 { read_bw {5} write_bw {5} read_avg_burst {4} write_avg_burst {4}} } \
 ] [get_bd_intf_pins /noc_ddr4/S03_INI]

  # Create instance: smartconnect_mipi2, and set properties
  set smartconnect_mipi2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi2 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_SI {2} \
  ] $smartconnect_mipi2


  # Create instance: smartconnect_mipi5, and set properties
  set smartconnect_mipi5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi5 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_SI {2} \
  ] $smartconnect_mipi5


  # Create instance: smartconnect_mipi6, and set properties
  set smartconnect_mipi6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi6 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_SI {2} \
  ] $smartconnect_mipi6


  # Create instance: smartconnect_mipi9, and set properties
  set smartconnect_mipi9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_mipi9 ]
  set_property -dict [list \
    CONFIG.NUM_CLKS {2} \
    CONFIG.NUM_SI {2} \
  ] $smartconnect_mipi9


  # Create instance: mipi_2
  create_hier_cell_mipi_2 [current_bd_instance .] mipi_2

  # Create instance: mipi_3
  create_hier_cell_mipi_3 [current_bd_instance .] mipi_3

  # Create interface connections
  connect_bd_intf_net -intf_net axi_noc_0_M00_AXI [get_bd_intf_pins ConfigNoc/M00_AXI] [get_bd_intf_pins ai_engine_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M00_INI [get_bd_intf_pins cips_noc/M00_INI] [get_bd_intf_pins noc_ddr4/S00_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M01_AXI [get_bd_intf_pins ConfigNoc/M01_AXI] [get_bd_intf_pins ai_engine_0/S01_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M01_INI [get_bd_intf_pins cips_noc/M01_INI] [get_bd_intf_pins noc_ddr4/S01_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M02_AXI [get_bd_intf_pins ConfigNoc/M02_AXI] [get_bd_intf_pins ai_engine_0/S02_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M02_INI [get_bd_intf_pins cips_noc/M02_INI] [get_bd_intf_pins noc_ddr4/S02_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M03_AXI [get_bd_intf_pins ConfigNoc/M03_AXI] [get_bd_intf_pins ai_engine_0/S03_AXI]
  connect_bd_intf_net -intf_net axi_noc_0_M03_INI [get_bd_intf_pins cips_noc/M03_INI] [get_bd_intf_pins noc_ddr4/S03_INI]
  connect_bd_intf_net -intf_net axi_noc_0_M04_AXI [get_bd_intf_pins ConfigNoc/M04_AXI] [get_bd_intf_pins ai_engine_0/S04_AXI]
  connect_bd_intf_net -intf_net cips_noc_M04_INI [get_bd_intf_pins ConfigNoc/S00_INI] [get_bd_intf_pins cips_noc/M04_INI]
  connect_bd_intf_net -intf_net cips_ss_0_FPD_CCI_NOC_0 [get_bd_intf_pins cips_noc/S00_AXI] [get_bd_intf_pins cips_ss_0/FPD_CCI_NOC_0]
  connect_bd_intf_net -intf_net cips_ss_0_FPD_CCI_NOC_1 [get_bd_intf_pins cips_noc/S01_AXI] [get_bd_intf_pins cips_ss_0/FPD_CCI_NOC_1]
  connect_bd_intf_net -intf_net cips_ss_0_FPD_CCI_NOC_2 [get_bd_intf_pins cips_noc/S02_AXI] [get_bd_intf_pins cips_ss_0/FPD_CCI_NOC_2]
  connect_bd_intf_net -intf_net cips_ss_0_FPD_CCI_NOC_3 [get_bd_intf_pins cips_noc/S03_AXI] [get_bd_intf_pins cips_ss_0/FPD_CCI_NOC_3]
  connect_bd_intf_net -intf_net cips_ss_0_IIC [get_bd_intf_ports HDMI_CTRL] [get_bd_intf_pins cips_ss_0/IIC]
  connect_bd_intf_net -intf_net cips_ss_0_LPD_AXI_NOC_0 [get_bd_intf_pins cips_noc/S04_AXI] [get_bd_intf_pins cips_ss_0/LPD_AXI_NOC_0]
  connect_bd_intf_net -intf_net cips_ss_0_M10_AXI [get_bd_intf_pins cips_ss_0/M10_AXI] [get_bd_intf_pins mipi_2/mipi_s_axi]
  connect_bd_intf_net -intf_net cips_ss_0_M_AXI [get_bd_intf_pins ConfigNoc/S00_AXI] [get_bd_intf_pins cips_ss_0/M_AXI]
  connect_bd_intf_net -intf_net cips_ss_0_PMC_NOC_AXI_0 [get_bd_intf_pins cips_noc/S05_AXI] [get_bd_intf_pins cips_ss_0/PMC_NOC_AXI_0]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins cips_ss_0/M01_AXI] [get_bd_intf_pins mipi_0/mipi_s_axi]
  connect_bd_intf_net -intf_net lpddr4_clk1_1 [get_bd_intf_ports lpddr4_clk1] [get_bd_intf_pins noc_ddr4/sys_clk0]
  connect_bd_intf_net -intf_net mipi_0_mm_video_scaled [get_bd_intf_pins mipi_0/mm_video_scaled] [get_bd_intf_pins smartconnect_mipi2/S01_AXI]
  connect_bd_intf_net -intf_net mipi_1_mm_video_scaled [get_bd_intf_pins mipi_1/mm_video_scaled] [get_bd_intf_pins smartconnect_mipi5/S01_AXI]
  connect_bd_intf_net -intf_net mipi_2_mm_video_scaled [get_bd_intf_pins smartconnect_mipi6/S01_AXI] [get_bd_intf_pins mipi_2/mm_video_scaled]
  connect_bd_intf_net -intf_net mipi_3_mm_video_scaled [get_bd_intf_pins smartconnect_mipi9/S01_AXI] [get_bd_intf_pins mipi_3/mm_video_scaled]
  connect_bd_intf_net -intf_net noc_ddr4_CH0_LPDDR4_0 [get_bd_intf_ports ch0_lpddr4_trip1] [get_bd_intf_pins noc_ddr4/CH0_LPDDR4_0]
  connect_bd_intf_net -intf_net noc_ddr4_CH1_LPDDR4_0 [get_bd_intf_ports ch1_lpddr4_trip1] [get_bd_intf_pins noc_ddr4/CH1_LPDDR4_0]
  connect_bd_intf_net -intf_net rpi_rx_0_gpio [get_bd_intf_ports rpi_rx_0_gpio] [get_bd_intf_pins mipi_0/rpi_gpio]
  connect_bd_intf_net -intf_net rpi_rx_0_mipi [get_bd_intf_ports rpi_rx_0_mipi] [get_bd_intf_pins mipi_0/mipi_phy_if_0]
  connect_bd_intf_net -intf_net rpi_rx_1_gpio [get_bd_intf_ports rpi_rx_1_gpio] [get_bd_intf_pins mipi_1/rpi_gpio]
  connect_bd_intf_net -intf_net rpi_rx_1_mipi [get_bd_intf_ports rpi_rx_1_mipi] [get_bd_intf_pins mipi_1/mipi_phy_if_0]
  connect_bd_intf_net -intf_net rpi_rx_2_gpio [get_bd_intf_ports rpi_rx_2_gpio] [get_bd_intf_pins mipi_2/rpi_gpio]
  connect_bd_intf_net -intf_net rpi_rx_2_mipi [get_bd_intf_ports rpi_rx_2_mipi] [get_bd_intf_pins mipi_2/mipi_phy_if_0]
  connect_bd_intf_net -intf_net rpi_rx_3_gpio [get_bd_intf_ports rpi_rx_3_gpio] [get_bd_intf_pins mipi_3/rpi_gpio]
  connect_bd_intf_net -intf_net rpi_rx_3_mipi [get_bd_intf_ports rpi_rx_3_mipi] [get_bd_intf_pins mipi_3/mipi_phy_if_0]
  connect_bd_intf_net -intf_net s_axi_CTRL_1 [get_bd_intf_pins cips_ss_0/M06_AXI] [get_bd_intf_pins mipi_1/mipi_s_axi]
  connect_bd_intf_net -intf_net s_axi_ctrl1_1 [get_bd_intf_pins cips_ss_0/M11_AXI] [get_bd_intf_pins mipi_3/mipi_s_axi]
  connect_bd_intf_net -intf_net smartconnect_mipi2_M00_AXI [get_bd_intf_pins cips_noc/S06_AXI] [get_bd_intf_pins smartconnect_mipi2/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi5_M00_AXI [get_bd_intf_pins cips_noc/S07_AXI] [get_bd_intf_pins smartconnect_mipi5/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi6_M00_AXI [get_bd_intf_pins cips_noc/S08_AXI] [get_bd_intf_pins smartconnect_mipi6/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_mipi9_M00_AXI [get_bd_intf_pins cips_noc/S09_AXI] [get_bd_intf_pins smartconnect_mipi9/M00_AXI]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins cips_ss_0/gpio_io_o] [get_bd_pins mipi_0/Din] [get_bd_pins mipi_1/Din] [get_bd_pins mipi_3/Din] [get_bd_pins mipi_2/Din]
  connect_bd_net -net aclk_1 [get_bd_pins cips_ss_0/clk2_300M] [get_bd_pins cips_noc/aclk6] [get_bd_pins smartconnect_mipi2/aclk1] [get_bd_pins smartconnect_mipi5/aclk1] [get_bd_pins smartconnect_mipi6/aclk1] [get_bd_pins smartconnect_mipi9/aclk1]
  connect_bd_net -net ai_engine_0_s00_axi_aclk [get_bd_pins ai_engine_0/s00_axi_aclk] [get_bd_pins ConfigNoc/aclk0]
  connect_bd_net -net ai_engine_0_s01_axi_aclk [get_bd_pins ai_engine_0/s01_axi_aclk] [get_bd_pins ConfigNoc/aclk1]
  connect_bd_net -net ai_engine_0_s02_axi_aclk [get_bd_pins ai_engine_0/s02_axi_aclk] [get_bd_pins ConfigNoc/aclk2]
  connect_bd_net -net ai_engine_0_s03_axi_aclk [get_bd_pins ai_engine_0/s03_axi_aclk] [get_bd_pins ConfigNoc/aclk3]
  connect_bd_net -net ai_engine_0_s04_axi_aclk [get_bd_pins ai_engine_0/s04_axi_aclk] [get_bd_pins ConfigNoc/aclk4]
  connect_bd_net -net cips_ss_0_fpd_cci_noc_axi0_clk [get_bd_pins cips_ss_0/fpd_cci_noc_axi0_clk] [get_bd_pins cips_noc/aclk0]
  connect_bd_net -net cips_ss_0_fpd_cci_noc_axi1_clk [get_bd_pins cips_ss_0/fpd_cci_noc_axi1_clk] [get_bd_pins cips_noc/aclk1]
  connect_bd_net -net cips_ss_0_fpd_cci_noc_axi2_clk [get_bd_pins cips_ss_0/fpd_cci_noc_axi2_clk] [get_bd_pins cips_noc/aclk2]
  connect_bd_net -net cips_ss_0_fpd_cci_noc_axi3_clk [get_bd_pins cips_ss_0/fpd_cci_noc_axi3_clk] [get_bd_pins cips_noc/aclk3]
  connect_bd_net -net cips_ss_0_lpd_axi_noc_clk [get_bd_pins cips_ss_0/lpd_axi_noc_clk] [get_bd_pins cips_noc/aclk7]
  connect_bd_net -net cips_ss_0_pmc_axi_noc_axi0_clk [get_bd_pins cips_ss_0/pmc_axi_noc_axi0_clk] [get_bd_pins cips_noc/aclk4]
  connect_bd_net -net clkoutphy_in_1 [get_bd_pins mipi_0/clkoutphy_out] [get_bd_pins mipi_1/clkoutphy_in] [get_bd_pins mipi_2/clkoutphy_in]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins cips_ss_0/clk_200M] [get_bd_pins mipi_0/dphy_clk_200M] [get_bd_pins mipi_1/dphy_clk_200M] [get_bd_pins mipi_3/dphy_clk_200M] [get_bd_pins mipi_2/dphy_clk_200M]
  connect_bd_net -net mipi_0_csirxss_csi_irq [get_bd_pins mipi_0/csirxss_csi_irq] [get_bd_pins cips_ss_0/In0]
  connect_bd_net -net mipi_0_vfbw_sc_irq [get_bd_pins mipi_0/vfbw_sc_irq] [get_bd_pins cips_ss_0/In1]
  connect_bd_net -net mipi_1_csirxss_csi_irq [get_bd_pins mipi_1/csirxss_csi_irq] [get_bd_pins cips_ss_0/In2]
  connect_bd_net -net mipi_1_vfbw_sc_irq [get_bd_pins mipi_1/vfbw_sc_irq] [get_bd_pins cips_ss_0/In3]
  connect_bd_net -net mipi_2_csirxss_csi_irq [get_bd_pins mipi_2/csirxss_csi_irq] [get_bd_pins cips_ss_0/In4]
  connect_bd_net -net mipi_2_vfbw_sc_irq [get_bd_pins mipi_2/vfbw_sc_irq] [get_bd_pins cips_ss_0/In5]
  connect_bd_net -net mipi_3_csirxss_csi_irq [get_bd_pins mipi_3/csirxss_csi_irq] [get_bd_pins cips_ss_0/In6]
  connect_bd_net -net mipi_3_vfbw_sc_irq [get_bd_pins mipi_3/vfbw_sc_irq] [get_bd_pins cips_ss_0/In7]
  connect_bd_net -net net_cips_ss_0_clk_out2 [get_bd_pins cips_ss_0/clk_250M] [get_bd_pins cips_noc/aclk5] [get_bd_pins mipi_0/video_aclk] [get_bd_pins mipi_1/video_aclk] [get_bd_pins smartconnect_mipi2/aclk] [get_bd_pins smartconnect_mipi5/aclk] [get_bd_pins smartconnect_mipi6/aclk] [get_bd_pins smartconnect_mipi9/aclk] [get_bd_pins mipi_3/video_aclk] [get_bd_pins mipi_2/video_aclk]
  connect_bd_net -net net_cips_ss_0_dcm_locked [get_bd_pins cips_ss_0/peripheral_aresetn_250M] [get_bd_pins mipi_0/video_aresetn] [get_bd_pins mipi_1/video_aresetn] [get_bd_pins smartconnect_mipi2/aresetn] [get_bd_pins smartconnect_mipi5/aresetn] [get_bd_pins smartconnect_mipi6/aresetn] [get_bd_pins smartconnect_mipi9/aresetn] [get_bd_pins mipi_3/video_aresetn] [get_bd_pins mipi_2/video_aresetn]
  connect_bd_net -net net_cips_ss_0_peripheral_aresetn [get_bd_pins cips_ss_0/peripheral_aresetn_100M] [get_bd_pins mipi_0/lite_aresetn] [get_bd_pins mipi_1/lite_aresetn] [get_bd_pins mipi_3/lite_aresetn] [get_bd_pins mipi_2/lite_aresetn]
  connect_bd_net -net net_cips_ss_0_s_axi_aclk [get_bd_pins cips_ss_0/s_axi_aclk] [get_bd_pins ConfigNoc/aclk5] [get_bd_pins mipi_0/lite_aclk] [get_bd_pins mipi_1/lite_aclk] [get_bd_pins mipi_3/lite_aclk] [get_bd_pins mipi_2/lite_aclk]
  connect_bd_net -net pll_lock_in_1 [get_bd_pins mipi_0/pll_lock_out] [get_bd_pins mipi_1/pll_lock_in] [get_bd_pins mipi_2/pll_lock_in]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins cips_ss_0/rx_en] [get_bd_ports rx_en] [get_bd_ports tx_en]

  # Create address segments
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_0] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_1] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_1] [get_bd_addr_segs noc_ddr4/S01_INI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_1] [get_bd_addr_segs noc_ddr4/S01_INI/C1_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_2] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_2] [get_bd_addr_segs noc_ddr4/S02_INI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_2] [get_bd_addr_segs noc_ddr4/S02_INI/C2_DDR_LOW1] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_3] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_3] [get_bd_addr_segs noc_ddr4/S03_INI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/FPD_CCI_NOC_3] [get_bd_addr_segs noc_ddr4/S03_INI/C3_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/LPD_AXI_NOC_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/LPD_AXI_NOC_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0xA4010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_0/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4090000 -range 0x00010000 -with_name SEG_ISPPipeline_accel_0_Reg_1 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_1/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4130000 -range 0x00010000 -with_name SEG_ISPPipeline_accel_0_Reg_2 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_3/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA40A0000 -range 0x00010000 -with_name SEG_ISPPipeline_accel_0_Reg_3 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_2/ISPPipeline_accel_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_gpio_1/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_gpio_2/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xA40F0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_intc_parent/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4150000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs cips_ss_0/axi_vip_0/S_AXI/Reg] -force
  assign_bd_address -offset 0xB0000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_0/csirx_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA4030000 -range 0x00002000 -with_name SEG_csirx_0_Reg_1 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_1/csirx_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA4034000 -range 0x00002000 -with_name SEG_csirx_0_Reg_2 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_3/csirx_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA4032000 -range 0x00002000 -with_name SEG_csirx_0_Reg_3 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_2/csirx_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0xA4260000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_3/rpi_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4060000 -range 0x00010000 -with_name SEG_rpi_gpio_Reg_1 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_0/rpi_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4110000 -range 0x00010000 -with_name SEG_rpi_gpio_Reg_2 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_1/rpi_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4120000 -range 0x00010000 -with_name SEG_rpi_gpio_Reg_3 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_2/rpi_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0xA4180000 -range 0x00040000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_0/v_proc_csc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA41C0000 -range 0x00040000 -with_name SEG_v_proc_csc_Reg_1 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_1/v_proc_csc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA4280000 -range 0x00040000 -with_name SEG_v_proc_csc_Reg_2 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_3/v_proc_csc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA4200000 -range 0x00040000 -with_name SEG_v_proc_csc_Reg_3 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_2/v_proc_csc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA40B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_0/vfbw_scaled/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA40D0000 -range 0x00010000 -with_name SEG_vfbw_scaled_Reg_1 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_1/vfbw_scaled/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA4250000 -range 0x00010000 -with_name SEG_vfbw_scaled_Reg_2 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_3/vfbw_scaled/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA40E0000 -range 0x00010000 -with_name SEG_vfbw_scaled_Reg_3 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/M_AXI_FPD] [get_bd_addr_segs mipi_2/vfbw_scaled/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x020000000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/PMC_NOC_AXI_0] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/PMC_NOC_AXI_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces cips_ss_0/versal_cips/PMC_NOC_AXI_0] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_0/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S01_INI/C1_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_0/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S01_INI/C1_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_1/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S02_INI/C2_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_1/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S02_INI/C2_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_2/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S03_INI/C3_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_2/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S03_INI/C3_DDR_LOW1] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_3/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW0] -force
  assign_bd_address -offset 0x000800000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_3/vfbw_scaled/Data_m_axi_mm_video] [get_bd_addr_segs noc_ddr4/S00_INI/C0_DDR_LOW1] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces cips_ss_0/axi_vip_1/Master_AXI] [get_bd_addr_segs ai_engine_0/S00_AXI/AIE_ARRAY_0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces cips_ss_0/axi_vip_1/Master_AXI] [get_bd_addr_segs ai_engine_0/S04_AXI/AIE_ARRAY_0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces cips_ss_0/axi_vip_1/Master_AXI] [get_bd_addr_segs ai_engine_0/S03_AXI/AIE_ARRAY_0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces cips_ss_0/axi_vip_1/Master_AXI] [get_bd_addr_segs ai_engine_0/S02_AXI/AIE_ARRAY_0]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces cips_ss_0/axi_vip_1/Master_AXI] [get_bd_addr_segs ai_engine_0/S01_AXI/AIE_ARRAY_0]


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM_NAME {tria-technologies.com:xd:ved2302_4rpiRx_hdmiTx:1.0} [get_files [current_bd_design].bd]
  set_property PFM.AXI_PORT {S10_AXI { memport "S_AXI_NOC" sptag "NOC_S10" memory "" is_range "true" }  S11_AXI { memport "S_AXI_NOC" sptag "NOC_S11" memory "" is_range "true" }  S12_AXI { memport "S_AXI_NOC" sptag "NOC_S12" memory "" is_range "true" }  S13_AXI { memport "S_AXI_NOC" sptag "NOC_S13" memory "" is_range "true" }  S14_AXI { memport "S_AXI_NOC" sptag "NOC_S14" memory "" is_range "true" }  S15_AXI { memport "S_AXI_NOC" sptag "NOC_S15" memory "" is_range "true" }  S16_AXI { memport "S_AXI_NOC" sptag "NOC_S16" memory "" is_range "true" }  S17_AXI { memport "S_AXI_NOC" sptag "NOC_S17" memory "" is_range "true" }  S18_AXI { memport "S_AXI_NOC" sptag "NOC_S18" memory "" is_range "true" }  S19_AXI { memport "S_AXI_NOC" sptag "NOC_S19" memory "" is_range "true" }  S20_AXI { memport "S_AXI_NOC" sptag "NOC_S20" memory "" is_range "true" }  S21_AXI { memport "S_AXI_NOC" sptag "NOC_S21" memory "" is_range "true" }  S22_AXI { memport "S_AXI_NOC" sptag "NOC_S22" memory "" is_range "true" }  S23_AXI { memport "S_AXI_NOC" sptag "NOC_S23" memory "" is_range "true" }  S24_AXI { memport "S_AXI_NOC" sptag "NOC_S24" memory "" is_range "true" }  S25_AXI { memport "S_AXI_NOC" sptag "NOC_S25" memory "" is_range "true" }  S26_AXI { memport "S_AXI_NOC" sptag "NOC_S26" memory "" is_range "true" }  S27_AXI { memport "S_AXI_NOC" sptag "NOC_S27" memory "" is_range "true" }  S28_AXI { memport "S_AXI_NOC" sptag "NOC_S28" memory "" is_range "true" }  S29_AXI { memport "S_AXI_NOC" sptag "NOC_S29" memory "" is_range "true" }  S30_AXI { memport "S_AXI_NOC" sptag "NOC_S30" memory "" is_range "true" }  S31_AXI { memport "S_AXI_NOC" sptag "NOC_S31" memory "" is_range "true" }  S32_AXI { memport "S_AXI_NOC" sptag "NOC_S32" memory "" is_range "true" }  S33_AXI { memport "S_AXI_NOC" sptag "NOC_S33" memory "" is_range "true" } } [get_bd_cells /cips_noc]
  set_property PFM.AXI_PORT {S00_AXI { memport "S_AXI_NOC" sptag "DDR" memory "" is_range "true" } } [get_bd_cells /noc_ddr4]
  set_property PFM.IRQ {intr { id 0 range 32 }} [get_bd_cells /cips_ss_0/axi_intc_0]
  set_property PFM.CLOCK {clk_out3 {id "1" is_default "false" proc_sys_reset "/cips_ss_0/rst_processor_250M_DPU" status "fixed" freq_hz "250000000"} clk_out4 {id "0" is_default "true" proc_sys_reset "/cips_ss_0/rst_processor_300M_DPU" status "fixed" freq_hz "300000000"} clk_out5 {id "2" is_default "false" proc_sys_reset "/cips_ss_0/rst_processor_150M_DPU" status "fixed" freq_hz "150000000"}} [get_bd_cells /cips_ss_0/clk_wizard_1]
  set_property PFM.AXI_PORT {M14_AXI { memport "M_AXI_GP" sptag "" memory "" is_range "true" } M15_AXI { memport "M_AXI_GP" sptag "" memory "" is_range "true" } } [get_bd_cells /cips_ss_0/smartconnect_0]
  set_property PFM.AXI_PORT {M01_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M02_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M03_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M04_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M05_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M06_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M07_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M08_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M09_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M10_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M11_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M12_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M13_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"} M14_AXI {memport "M_AXI_GP" sptag "" memory "" is_range "true"}} [get_bd_cells /cips_ss_0/smartconnect_1]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


