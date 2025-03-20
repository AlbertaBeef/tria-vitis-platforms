
################################################################
# This is a generated script based on design: uz7ev_evcc_camerafmc
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
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source uz7ev_evcc_camerafmc_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu7ev-fbvb900-1-i
   set_property BOARD_PART avnet.com:ultrazed_7ev_cc:part0:1.5 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name uz7ev_evcc_camerafmc

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
xilinx.com:ip:axi_intc:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:clk_wiz:*\
xilinx.com:ip:xlconcat:*\
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:axi_gpio:*\
xilinx.com:ip:smartconnect:*\
xilinx.com:ip:xdma:*\
xilinx.com:ip:zynq_ultra_ps_e:*\
xilinx.com:ip:axis_subset_converter:*\
xilinx.com:ip:xlslice:*\
xilinx.com:ip:v_axi4s_vid_out:*\
xilinx.com:ip:v_mix:*\
xilinx.com:ip:v_tc:*\
xilinx.com:ip:axi_iic:*\
xilinx.com:hls:ISPPipeline_accel:*\
xilinx.com:ip:mipi_csi2_rx_subsystem:*\
xilinx.com:ip:v_frmbuf_wr:*\
xilinx.com:ip:v_proc_ss:*\
xilinx.com:ip:axi_register_slice:*\
xilinx.com:ip:vcu:*\
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


# Hierarchical cell: vcu
proc create_hier_cell_vcu { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_vcu() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI_VCU_DEC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI_VCU_EN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_VCU_MCU

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE


  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -type clk m_axi_dec_aclk
  create_bd_pin -dir I -type clk pll_ref_clk
  create_bd_pin -dir I -type clk s_axi_lite_aclk
  create_bd_pin -dir O -type intr vcu_host_interrupt

  # Create instance: axi_ic_vcu_dec, and set properties
  set axi_ic_vcu_dec [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic_vcu_dec ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
 ] $axi_ic_vcu_dec

  # Create instance: axi_ic_vcu_enc, and set properties
  set axi_ic_vcu_enc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic_vcu_enc ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
 ] $axi_ic_vcu_enc

  # Create instance: axi_reg_slice_vmcu, and set properties
  set axi_reg_slice_vmcu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice axi_reg_slice_vmcu ]

  # Create instance: vcu_0, and set properties
  set vcu_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vcu vcu_0 ]
  set_property -dict [ list \
   CONFIG.DEC_CODING_TYPE {0} \
   CONFIG.DEC_COLOR_DEPTH {0} \
   CONFIG.DEC_COLOR_FORMAT {0} \
   CONFIG.DEC_FPS {1} \
   CONFIG.DEC_FRAME_SIZE {4} \
   CONFIG.ENABLE_DECODER {true} \
   CONFIG.ENC_BUFFER_EN {true} \
   CONFIG.ENC_BUFFER_MANUAL_OVERRIDE {1} \
   CONFIG.ENC_BUFFER_SIZE {253} \
   CONFIG.ENC_BUFFER_SIZE_ACTUAL {284} \
   CONFIG.ENC_BUFFER_TYPE {0} \
   CONFIG.ENC_CODING_TYPE {1} \
   CONFIG.ENC_COLOR_DEPTH {0} \
   CONFIG.ENC_COLOR_FORMAT {0} \
   CONFIG.ENC_FPS {1} \
   CONFIG.ENC_FRAME_SIZE {4} \
   CONFIG.ENC_MEM_BRAM_USED {0} \
   CONFIG.ENC_MEM_URAM_USED {284} \
   CONFIG.NO_OF_DEC_STREAMS {1} \
   CONFIG.NO_OF_STREAMS {1} \
   CONFIG.TABLE_NO {2} \
 ] $vcu_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_ic_vcu_enc/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC0]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_ic_vcu_dec/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC0]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_ic_vcu_enc/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC1]
  connect_bd_intf_net -intf_net S01_AXI_2 [get_bd_intf_pins axi_ic_vcu_dec/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC1]
  connect_bd_intf_net -intf_net axi_ic_vcu_dec_M00_AXI [get_bd_intf_pins M00_AXI_VCU_DEC] [get_bd_intf_pins axi_ic_vcu_dec/M00_AXI]
  connect_bd_intf_net -intf_net axi_ic_vcu_enc_M00_AXI [get_bd_intf_pins M00_AXI_VCU_EN] [get_bd_intf_pins axi_ic_vcu_enc/M00_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins M_AXI_VCU_MCU] [get_bd_intf_pins axi_reg_slice_vmcu/M_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins vcu_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_MCU [get_bd_intf_pins axi_reg_slice_vmcu/S_AXI] [get_bd_intf_pins vcu_0/M_AXI_MCU]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net clk_wiz_0_clk_100M [get_bd_pins s_axi_lite_aclk] [get_bd_pins vcu_0/s_axi_lite_aclk]
  connect_bd_net -net clk_wiz_0_clk_300M [get_bd_pins m_axi_dec_aclk] [get_bd_pins axi_ic_vcu_dec/ACLK] [get_bd_pins axi_ic_vcu_dec/M00_ACLK] [get_bd_pins axi_ic_vcu_dec/S00_ACLK] [get_bd_pins axi_ic_vcu_dec/S01_ACLK] [get_bd_pins axi_ic_vcu_enc/ACLK] [get_bd_pins axi_ic_vcu_enc/M00_ACLK] [get_bd_pins axi_ic_vcu_enc/S00_ACLK] [get_bd_pins axi_ic_vcu_enc/S01_ACLK] [get_bd_pins axi_reg_slice_vmcu/aclk] [get_bd_pins vcu_0/m_axi_dec_aclk] [get_bd_pins vcu_0/m_axi_enc_aclk] [get_bd_pins vcu_0/m_axi_mcu_aclk]
  connect_bd_net -net clk_wiz_0_clk_50M [get_bd_pins pll_ref_clk] [get_bd_pins vcu_0/pll_ref_clk]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axi_ic_vcu_dec/ARESETN] [get_bd_pins axi_ic_vcu_dec/M00_ARESETN] [get_bd_pins axi_ic_vcu_dec/S00_ARESETN] [get_bd_pins axi_ic_vcu_dec/S01_ARESETN] [get_bd_pins axi_ic_vcu_enc/ARESETN] [get_bd_pins axi_ic_vcu_enc/M00_ARESETN] [get_bd_pins axi_ic_vcu_enc/S00_ARESETN] [get_bd_pins axi_ic_vcu_enc/S01_ARESETN] [get_bd_pins axi_reg_slice_vmcu/aresetn]
  connect_bd_net -net vcu_0_vcu_host_interrupt [get_bd_pins vcu_host_interrupt] [get_bd_pins vcu_0/vcu_host_interrupt]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins vcu_0/vcu_resetn] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if


  # Create pins
  create_bd_pin -dir I aresetn
  create_bd_pin -dir I dphy_clk_200M
  create_bd_pin -dir I -from 94 -to 0 emio_gpio
  create_bd_pin -dir O frmbufwr_irq
  create_bd_pin -dir O iic2intc_irpt
  create_bd_pin -dir O isppipeline_irq
  create_bd_pin -dir I mipi_3_bg0_pin0_nc
  create_bd_pin -dir O mipi_sub_irq
  create_bd_pin -dir I s_axi_lite_aclk
  create_bd_pin -dir I video_aclk
  create_bd_pin -dir I video_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_0

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: axi_int_ctrl, and set properties
  set axi_int_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_ctrl ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_ctrl

  # Create instance: axi_int_video, and set properties
  set axi_int_video [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_video ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_video

  # Create instance: isppipeline, and set properties
  set isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel isppipeline ]

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem mipi_csi2_rx_subsyst_0 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AK9} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L7P_T1L_N0_QBC_AD13P_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_NUM_PIXELS {1} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_EN_CSI_V2_0 {true} \
   CONFIG.C_HS_LINE_RATE {420} \
   CONFIG.C_HS_SETTLE_NS {158} \
   CONFIG.DATA_LANE0_IO_LOC {AG11} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L3P_T0L_N4_AD15P_65} \
   CONFIG.DATA_LANE1_IO_LOC {AJ11} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L4P_T0U_N6_DBC_AD7P_SMBALERT_65} \
   CONFIG.DPY_LINE_RATE {420} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_0

  # Create instance: reset_frmbuf_wr, and set properties
  set reset_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {34} \
   CONFIG.DIN_TO {34} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_frmbuf_wr

  # Create instance: reset_isppipeline, and set properties
  set reset_isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_isppipeline ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {32} \
   CONFIG.DIN_TO {32} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_isppipeline

  # Create instance: reset_v_proc, and set properties
  set reset_v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_v_proc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {33} \
   CONFIG.DIN_TO {33} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_v_proc

  # Create instance: v_frmbuf_wr, and set properties
  set v_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {1920} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.MAX_ROWS {1232} \
   CONFIG.SAMPLES_PER_CLOCK {1} \
 ] $v_frmbuf_wr

  # Create instance: v_proc, and set properties
  set v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_ENABLE_DMA {false} \
   CONFIG.C_MAX_COLS {1920} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_MAX_ROWS {1232} \
   CONFIG.C_SAMPLES_PER_CLK {1} \
   CONFIG.C_SCALER_ALGORITHM {2} \
   CONFIG.C_TOPOLOGY {0} \
 ] $v_proc

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axi_int_ctrl/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_VIDEO_1 [get_bd_intf_pins S_AXI_VIDEO] [get_bd_intf_pins axi_int_video/S00_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_pins GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_int_ctrl_M00_AXI [get_bd_intf_pins axi_int_ctrl/M00_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_int_ctrl_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M01_AXI]
  connect_bd_intf_net -intf_net axi_int_ctrl_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M02_AXI]
  connect_bd_intf_net -intf_net axi_int_video_M00_AXI [get_bd_intf_pins axi_int_video/M00_AXI] [get_bd_intf_pins isppipeline/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M01_AXI [get_bd_intf_pins axi_int_video/M01_AXI] [get_bd_intf_pins v_frmbuf_wr/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M02_AXI [get_bd_intf_pins axi_int_video/M02_AXI] [get_bd_intf_pins v_proc/s_axi_ctrl]
  connect_bd_intf_net -intf_net isppipeline_m_axis_video [get_bd_intf_pins isppipeline/m_axis_video] [get_bd_intf_pins v_proc/s_axis]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins isppipeline/s_axis_video] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_if_1 [get_bd_intf_pins mipi_phy_if] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net v_frmbuf_wr_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_wr/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_m_axis [get_bd_intf_pins v_frmbuf_wr/s_axis_video] [get_bd_intf_pins v_proc/m_axis]

  # Create port connections
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_int_ctrl/ARESETN] [get_bd_pins axi_int_ctrl/M00_ARESETN] [get_bd_pins axi_int_ctrl/M01_ARESETN] [get_bd_pins axi_int_ctrl/M02_ARESETN] [get_bd_pins axi_int_ctrl/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net emio_gpio_1 [get_bd_pins emio_gpio] [get_bd_pins reset_frmbuf_wr/Din] [get_bd_pins reset_isppipeline/Din] [get_bd_pins reset_v_proc/Din]
  connect_bd_net -net isppipeline_interrupt [get_bd_pins isppipeline_irq] [get_bd_pins isppipeline/interrupt]
  connect_bd_net -net mipi_3_bg0_pin0_nc_1 [get_bd_pins mipi_3_bg0_pin0_nc] [get_bd_pins mipi_csi2_rx_subsyst_0/bg0_pin0_nc]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins mipi_sub_irq] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net reset_frmbuf_wr_Dout [get_bd_pins reset_frmbuf_wr/Dout] [get_bd_pins v_frmbuf_wr/ap_rst_n]
  connect_bd_net -net reset_isppipeline_Dout [get_bd_pins isppipeline/ap_rst_n] [get_bd_pins reset_isppipeline/Dout]
  connect_bd_net -net reset_v_proc_Dout [get_bd_pins reset_v_proc/Dout] [get_bd_pins v_proc/aresetn_ctrl]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_int_ctrl/ACLK] [get_bd_pins axi_int_ctrl/M00_ACLK] [get_bd_pins axi_int_ctrl/M01_ACLK] [get_bd_pins axi_int_ctrl/M02_ACLK] [get_bd_pins axi_int_ctrl/S00_ACLK] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
  connect_bd_net -net v_frmbuf_wr_interrupt [get_bd_pins frmbufwr_irq] [get_bd_pins v_frmbuf_wr/interrupt]
  connect_bd_net -net video_aclk_1 [get_bd_pins video_aclk] [get_bd_pins axi_int_video/ACLK] [get_bd_pins axi_int_video/M00_ACLK] [get_bd_pins axi_int_video/M01_ACLK] [get_bd_pins axi_int_video/M02_ACLK] [get_bd_pins axi_int_video/S00_ACLK] [get_bd_pins isppipeline/ap_clk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins v_frmbuf_wr/ap_clk] [get_bd_pins v_proc/aclk_axis] [get_bd_pins v_proc/aclk_ctrl]
  connect_bd_net -net video_aresetn_1 [get_bd_pins video_aresetn] [get_bd_pins axi_int_video/ARESETN] [get_bd_pins axi_int_video/M00_ARESETN] [get_bd_pins axi_int_video/M01_ARESETN] [get_bd_pins axi_int_video/M02_ARESETN] [get_bd_pins axi_int_video/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if


  # Create pins
  create_bd_pin -dir I aresetn
  create_bd_pin -dir I dphy_clk_200M
  create_bd_pin -dir I -from 94 -to 0 emio_gpio
  create_bd_pin -dir O frmbufwr_irq
  create_bd_pin -dir O iic2intc_irpt
  create_bd_pin -dir O isppipeline_irq
  create_bd_pin -dir O mipi_sub_irq
  create_bd_pin -dir I s_axi_lite_aclk
  create_bd_pin -dir I video_aclk
  create_bd_pin -dir I video_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_0

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: axi_int_ctrl, and set properties
  set axi_int_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_ctrl ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_ctrl

  # Create instance: axi_int_video, and set properties
  set axi_int_video [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_video ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_video

  # Create instance: isppipeline, and set properties
  set isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel isppipeline ]

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem mipi_csi2_rx_subsyst_0 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AH6} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_65} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_NUM_PIXELS {1} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_EN_CSI_V2_0 {true} \
   CONFIG.C_HS_LINE_RATE {420} \
   CONFIG.C_HS_SETTLE_NS {158} \
   CONFIG.DATA_LANE0_IO_LOC {AK7} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L15P_T2L_N4_AD11P_65} \
   CONFIG.DATA_LANE1_IO_LOC {AG6} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L14P_T2L_N2_GC_65} \
   CONFIG.DPY_LINE_RATE {420} \
   CONFIG.HP_IO_BANK_SELECTION {65} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_0

  # Create instance: reset_frmbuf_wr, and set properties
  set reset_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {26} \
   CONFIG.DIN_TO {26} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_frmbuf_wr

  # Create instance: reset_isppipeline, and set properties
  set reset_isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_isppipeline ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {24} \
   CONFIG.DIN_TO {24} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_isppipeline

  # Create instance: reset_v_proc, and set properties
  set reset_v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_v_proc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {25} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_v_proc

  # Create instance: v_frmbuf_wr, and set properties
  set v_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {1920} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.MAX_ROWS {1232} \
   CONFIG.SAMPLES_PER_CLOCK {1} \
 ] $v_frmbuf_wr

  # Create instance: v_proc, and set properties
  set v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_ENABLE_DMA {false} \
   CONFIG.C_MAX_COLS {1920} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_MAX_ROWS {1232} \
   CONFIG.C_SAMPLES_PER_CLK {1} \
   CONFIG.C_SCALER_ALGORITHM {2} \
   CONFIG.C_TOPOLOGY {0} \
 ] $v_proc

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axi_int_ctrl/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_VIDEO_1 [get_bd_intf_pins S_AXI_VIDEO] [get_bd_intf_pins axi_int_video/S00_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_pins GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_int_ctrl_M00_AXI [get_bd_intf_pins axi_int_ctrl/M00_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_int_ctrl_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M01_AXI]
  connect_bd_intf_net -intf_net axi_int_ctrl_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M02_AXI]
  connect_bd_intf_net -intf_net axi_int_video_M00_AXI [get_bd_intf_pins axi_int_video/M00_AXI] [get_bd_intf_pins isppipeline/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M01_AXI [get_bd_intf_pins axi_int_video/M01_AXI] [get_bd_intf_pins v_frmbuf_wr/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M02_AXI [get_bd_intf_pins axi_int_video/M02_AXI] [get_bd_intf_pins v_proc/s_axi_ctrl]
  connect_bd_intf_net -intf_net isppipeline_m_axis_video [get_bd_intf_pins isppipeline/m_axis_video] [get_bd_intf_pins v_proc/s_axis]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins isppipeline/s_axis_video] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_if_1 [get_bd_intf_pins mipi_phy_if] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net v_frmbuf_wr_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_wr/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_m_axis [get_bd_intf_pins v_frmbuf_wr/s_axis_video] [get_bd_intf_pins v_proc/m_axis]

  # Create port connections
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_int_ctrl/ARESETN] [get_bd_pins axi_int_ctrl/M00_ARESETN] [get_bd_pins axi_int_ctrl/M01_ARESETN] [get_bd_pins axi_int_ctrl/M02_ARESETN] [get_bd_pins axi_int_ctrl/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net emio_gpio_1 [get_bd_pins emio_gpio] [get_bd_pins reset_frmbuf_wr/Din] [get_bd_pins reset_isppipeline/Din] [get_bd_pins reset_v_proc/Din]
  connect_bd_net -net isppipeline_interrupt [get_bd_pins isppipeline_irq] [get_bd_pins isppipeline/interrupt]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins mipi_sub_irq] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net reset_frmbuf_wr_Dout [get_bd_pins reset_frmbuf_wr/Dout] [get_bd_pins v_frmbuf_wr/ap_rst_n]
  connect_bd_net -net reset_isppipeline_Dout [get_bd_pins isppipeline/ap_rst_n] [get_bd_pins reset_isppipeline/Dout]
  connect_bd_net -net reset_v_proc_Dout [get_bd_pins reset_v_proc/Dout] [get_bd_pins v_proc/aresetn_ctrl]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_int_ctrl/ACLK] [get_bd_pins axi_int_ctrl/M00_ACLK] [get_bd_pins axi_int_ctrl/M01_ACLK] [get_bd_pins axi_int_ctrl/M02_ACLK] [get_bd_pins axi_int_ctrl/S00_ACLK] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
  connect_bd_net -net v_frmbuf_wr_interrupt [get_bd_pins frmbufwr_irq] [get_bd_pins v_frmbuf_wr/interrupt]
  connect_bd_net -net video_aclk_1 [get_bd_pins video_aclk] [get_bd_pins axi_int_video/ACLK] [get_bd_pins axi_int_video/M00_ACLK] [get_bd_pins axi_int_video/M01_ACLK] [get_bd_pins axi_int_video/M02_ACLK] [get_bd_pins axi_int_video/S00_ACLK] [get_bd_pins isppipeline/ap_clk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins v_frmbuf_wr/ap_clk] [get_bd_pins v_proc/aclk_axis] [get_bd_pins v_proc/aclk_ctrl]
  connect_bd_net -net video_aresetn_1 [get_bd_pins video_aresetn] [get_bd_pins axi_int_video/ARESETN] [get_bd_pins axi_int_video/M00_ARESETN] [get_bd_pins axi_int_video/M01_ARESETN] [get_bd_pins axi_int_video/M02_ARESETN] [get_bd_pins axi_int_video/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if


  # Create pins
  create_bd_pin -dir I aresetn
  create_bd_pin -dir I dphy_clk_200M
  create_bd_pin -dir I -from 94 -to 0 emio_gpio
  create_bd_pin -dir O frmbufwr_irq
  create_bd_pin -dir O iic2intc_irpt
  create_bd_pin -dir O isppipeline_irq
  create_bd_pin -dir O mipi_sub_irq
  create_bd_pin -dir I s_axi_lite_aclk
  create_bd_pin -dir I video_aclk
  create_bd_pin -dir I video_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_0

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: axi_int_ctrl, and set properties
  set axi_int_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_ctrl ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_ctrl

  # Create instance: axi_int_video, and set properties
  set axi_int_video [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_video ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_video

  # Create instance: isppipeline, and set properties
  set isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel isppipeline ]

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem mipi_csi2_rx_subsyst_0 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AG13} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L7P_T1L_N0_QBC_AD13P_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_NUM_PIXELS {1} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_EN_CSI_V2_0 {true} \
   CONFIG.C_HS_LINE_RATE {420} \
   CONFIG.C_HS_SETTLE_NS {158} \
   CONFIG.DATA_LANE0_IO_LOC {AK13} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L8P_T1L_N2_AD5P_64} \
   CONFIG.DATA_LANE1_IO_LOC {AF15} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L12P_T1U_N10_GC_64} \
   CONFIG.DPY_LINE_RATE {420} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_0

  # Create instance: reset_frmbuf_wr, and set properties
  set reset_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {18} \
   CONFIG.DIN_TO {18} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_frmbuf_wr

  # Create instance: reset_isppipeline, and set properties
  set reset_isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_isppipeline ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {16} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_isppipeline

  # Create instance: reset_v_proc, and set properties
  set reset_v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_v_proc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {17} \
   CONFIG.DIN_TO {17} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_v_proc

  # Create instance: v_frmbuf_wr, and set properties
  set v_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {1920} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.MAX_ROWS {1232} \
   CONFIG.SAMPLES_PER_CLOCK {1} \
 ] $v_frmbuf_wr

  # Create instance: v_proc, and set properties
  set v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_ENABLE_DMA {false} \
   CONFIG.C_MAX_COLS {1920} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_MAX_ROWS {1232} \
   CONFIG.C_SAMPLES_PER_CLK {1} \
   CONFIG.C_SCALER_ALGORITHM {2} \
   CONFIG.C_TOPOLOGY {0} \
 ] $v_proc

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axi_int_ctrl/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_VIDEO_1 [get_bd_intf_pins S_AXI_VIDEO] [get_bd_intf_pins axi_int_video/S00_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_pins GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_int_ctrl_M00_AXI [get_bd_intf_pins axi_int_ctrl/M00_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_int_ctrl_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M01_AXI]
  connect_bd_intf_net -intf_net axi_int_ctrl_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M02_AXI]
  connect_bd_intf_net -intf_net axi_int_video_M00_AXI [get_bd_intf_pins axi_int_video/M00_AXI] [get_bd_intf_pins isppipeline/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M01_AXI [get_bd_intf_pins axi_int_video/M01_AXI] [get_bd_intf_pins v_frmbuf_wr/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M02_AXI [get_bd_intf_pins axi_int_video/M02_AXI] [get_bd_intf_pins v_proc/s_axi_ctrl]
  connect_bd_intf_net -intf_net isppipeline_m_axis_video [get_bd_intf_pins isppipeline/m_axis_video] [get_bd_intf_pins v_proc/s_axis]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins isppipeline/s_axis_video] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_if_1 [get_bd_intf_pins mipi_phy_if] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net v_frmbuf_wr_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_wr/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_m_axis [get_bd_intf_pins v_frmbuf_wr/s_axis_video] [get_bd_intf_pins v_proc/m_axis]

  # Create port connections
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_int_ctrl/ARESETN] [get_bd_pins axi_int_ctrl/M00_ARESETN] [get_bd_pins axi_int_ctrl/M01_ARESETN] [get_bd_pins axi_int_ctrl/M02_ARESETN] [get_bd_pins axi_int_ctrl/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net emio_gpio_1 [get_bd_pins emio_gpio] [get_bd_pins reset_frmbuf_wr/Din] [get_bd_pins reset_isppipeline/Din] [get_bd_pins reset_v_proc/Din]
  connect_bd_net -net isppipeline_interrupt [get_bd_pins isppipeline_irq] [get_bd_pins isppipeline/interrupt]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins mipi_sub_irq] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net reset_frmbuf_wr_Dout [get_bd_pins reset_frmbuf_wr/Dout] [get_bd_pins v_frmbuf_wr/ap_rst_n]
  connect_bd_net -net reset_isppipeline_Dout [get_bd_pins isppipeline/ap_rst_n] [get_bd_pins reset_isppipeline/Dout]
  connect_bd_net -net reset_v_proc_Dout [get_bd_pins reset_v_proc/Dout] [get_bd_pins v_proc/aresetn_ctrl]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_int_ctrl/ACLK] [get_bd_pins axi_int_ctrl/M00_ACLK] [get_bd_pins axi_int_ctrl/M01_ACLK] [get_bd_pins axi_int_ctrl/M02_ACLK] [get_bd_pins axi_int_ctrl/S00_ACLK] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
  connect_bd_net -net v_frmbuf_wr_interrupt [get_bd_pins frmbufwr_irq] [get_bd_pins v_frmbuf_wr/interrupt]
  connect_bd_net -net video_aclk_1 [get_bd_pins video_aclk] [get_bd_pins axi_int_video/ACLK] [get_bd_pins axi_int_video/M00_ACLK] [get_bd_pins axi_int_video/M01_ACLK] [get_bd_pins axi_int_video/M02_ACLK] [get_bd_pins axi_int_video/S00_ACLK] [get_bd_pins isppipeline/ap_clk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins v_frmbuf_wr/ap_clk] [get_bd_pins v_proc/aclk_axis] [get_bd_pins v_proc/aclk_ctrl]
  connect_bd_net -net video_aresetn_1 [get_bd_pins video_aresetn] [get_bd_pins axi_int_video/ARESETN] [get_bd_pins axi_int_video/M00_ARESETN] [get_bd_pins axi_int_video/M01_ARESETN] [get_bd_pins axi_int_video/M02_ARESETN] [get_bd_pins axi_int_video/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_VIDEO

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if


  # Create pins
  create_bd_pin -dir I aresetn
  create_bd_pin -dir I dphy_clk_200M
  create_bd_pin -dir I -from 94 -to 0 emio_gpio
  create_bd_pin -dir O frmbufwr_irq
  create_bd_pin -dir O iic2intc_irpt
  create_bd_pin -dir O isppipeline_irq
  create_bd_pin -dir I mipi_0_bg3_pin0_nc
  create_bd_pin -dir O mipi_sub_irq
  create_bd_pin -dir I s_axi_lite_aclk
  create_bd_pin -dir I video_aclk
  create_bd_pin -dir I video_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_0

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic axi_iic_0 ]

  # Create instance: axi_int_ctrl, and set properties
  set axi_int_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_ctrl ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_ctrl

  # Create instance: axi_int_video, and set properties
  set axi_int_video [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_int_video ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_int_video

  # Create instance: isppipeline, and set properties
  set isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:hls:ISPPipeline_accel isppipeline ]

  # Create instance: mipi_csi2_rx_subsyst_0, and set properties
  set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem mipi_csi2_rx_subsyst_0 ]
  set_property -dict [ list \
   CONFIG.CLK_LANE_IO_LOC {AF16} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_64} \
   CONFIG.CMN_NUM_LANES {2} \
   CONFIG.CMN_NUM_PIXELS {1} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.C_DPHY_LANES {2} \
   CONFIG.C_EN_CSI_V2_0 {true} \
   CONFIG.C_HS_LINE_RATE {420} \
   CONFIG.C_HS_SETTLE_NS {158} \
   CONFIG.DATA_LANE0_IO_LOC {AC17} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L17P_T2U_N8_AD10P_64} \
   CONFIG.DATA_LANE1_IO_LOC {AG18} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L23P_T3U_N8_64} \
   CONFIG.DPY_LINE_RATE {420} \
   CONFIG.HP_IO_BANK_SELECTION {64} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsyst_0

  # Create instance: reset_frmbuf_wr, and set properties
  set reset_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {10} \
   CONFIG.DIN_TO {10} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_frmbuf_wr

  # Create instance: reset_isppipeline, and set properties
  set reset_isppipeline [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_isppipeline ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {8} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_isppipeline

  # Create instance: reset_v_proc, and set properties
  set reset_v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_v_proc ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {9} \
   CONFIG.DIN_TO {9} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_v_proc

  # Create instance: v_frmbuf_wr, and set properties
  set v_frmbuf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {1920} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.MAX_ROWS {1232} \
   CONFIG.SAMPLES_PER_CLOCK {1} \
 ] $v_frmbuf_wr

  # Create instance: v_proc, and set properties
  set v_proc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_ENABLE_DMA {false} \
   CONFIG.C_MAX_COLS {1920} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_MAX_ROWS {1232} \
   CONFIG.C_SAMPLES_PER_CLK {1} \
   CONFIG.C_SCALER_ALGORITHM {2} \
   CONFIG.C_TOPOLOGY {0} \
 ] $v_proc

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axi_int_ctrl/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_VIDEO_1 [get_bd_intf_pins S_AXI_VIDEO] [get_bd_intf_pins axi_int_video/S00_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_pins GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_int_ctrl_M00_AXI [get_bd_intf_pins axi_int_ctrl/M00_AXI] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net axi_int_ctrl_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M01_AXI]
  connect_bd_intf_net -intf_net axi_int_ctrl_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_int_ctrl/M02_AXI]
  connect_bd_intf_net -intf_net axi_int_video_M00_AXI [get_bd_intf_pins axi_int_video/M00_AXI] [get_bd_intf_pins isppipeline/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M01_AXI [get_bd_intf_pins axi_int_video/M01_AXI] [get_bd_intf_pins v_frmbuf_wr/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_int_video_M02_AXI [get_bd_intf_pins axi_int_video/M02_AXI] [get_bd_intf_pins v_proc/s_axi_ctrl]
  connect_bd_intf_net -intf_net isppipeline_m_axis_video [get_bd_intf_pins isppipeline/m_axis_video] [get_bd_intf_pins v_proc/s_axis]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsyst_0_video_out [get_bd_intf_pins isppipeline/s_axis_video] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_if_1 [get_bd_intf_pins mipi_phy_if] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
  connect_bd_intf_net -intf_net v_frmbuf_wr_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_wr/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_m_axis [get_bd_intf_pins v_frmbuf_wr/s_axis_video] [get_bd_intf_pins v_proc/m_axis]

  # Create port connections
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_int_ctrl/ARESETN] [get_bd_pins axi_int_ctrl/M00_ARESETN] [get_bd_pins axi_int_ctrl/M01_ARESETN] [get_bd_pins axi_int_ctrl/M02_ARESETN] [get_bd_pins axi_int_ctrl/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
  connect_bd_net -net emio_gpio_1 [get_bd_pins emio_gpio] [get_bd_pins reset_frmbuf_wr/Din] [get_bd_pins reset_isppipeline/Din] [get_bd_pins reset_v_proc/Din]
  connect_bd_net -net isppipeline_interrupt [get_bd_pins isppipeline_irq] [get_bd_pins isppipeline/interrupt]
  connect_bd_net -net mipi_0_bg3_pin0_nc_1 [get_bd_pins mipi_0_bg3_pin0_nc] [get_bd_pins mipi_csi2_rx_subsyst_0/bg3_pin0_nc]
  connect_bd_net -net mipi_csi2_rx_subsyst_0_csirxss_csi_irq [get_bd_pins mipi_sub_irq] [get_bd_pins mipi_csi2_rx_subsyst_0/csirxss_csi_irq]
  connect_bd_net -net reset_frmbuf_wr_Dout [get_bd_pins reset_frmbuf_wr/Dout] [get_bd_pins v_frmbuf_wr/ap_rst_n]
  connect_bd_net -net reset_isppipeline_Dout [get_bd_pins isppipeline/ap_rst_n] [get_bd_pins reset_isppipeline/Dout]
  connect_bd_net -net reset_v_proc_Dout [get_bd_pins reset_v_proc/Dout] [get_bd_pins v_proc/aresetn_ctrl]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_int_ctrl/ACLK] [get_bd_pins axi_int_ctrl/M00_ACLK] [get_bd_pins axi_int_ctrl/M01_ACLK] [get_bd_pins axi_int_ctrl/M02_ACLK] [get_bd_pins axi_int_ctrl/S00_ACLK] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
  connect_bd_net -net v_frmbuf_wr_interrupt [get_bd_pins frmbufwr_irq] [get_bd_pins v_frmbuf_wr/interrupt]
  connect_bd_net -net video_aclk_1 [get_bd_pins video_aclk] [get_bd_pins axi_int_video/ACLK] [get_bd_pins axi_int_video/M00_ACLK] [get_bd_pins axi_int_video/M01_ACLK] [get_bd_pins axi_int_video/M02_ACLK] [get_bd_pins axi_int_video/S00_ACLK] [get_bd_pins isppipeline/ap_clk] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk] [get_bd_pins v_frmbuf_wr/ap_clk] [get_bd_pins v_proc/aclk_axis] [get_bd_pins v_proc/aclk_ctrl]
  connect_bd_net -net video_aresetn_1 [get_bd_pins video_aresetn] [get_bd_pins axi_int_video/ARESETN] [get_bd_pins axi_int_video/M00_ARESETN] [get_bd_pins axi_int_video/M01_ARESETN] [get_bd_pins axi_int_video/M02_ARESETN] [get_bd_pins axi_int_video/S00_ARESETN] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: display_pipeline
proc create_hier_cell_display_pipeline { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_display_pipeline() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_clk_wiz

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_v_tc

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_vmix


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -from 94 -to 0 emio_gpio
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir O -type intr irq_v_tc
  create_bd_pin -dir O -type intr irq_vmix
  create_bd_pin -dir I -type rst resetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O vid_active_video
  create_bd_pin -dir O -from 35 -to 0 vid_data
  create_bd_pin -dir O vid_hsync
  create_bd_pin -dir O vid_vsync
  create_bd_pin -dir O video_clk

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {5} \
 ] $axi_interconnect_0

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {2} \
   CONFIG.S_TDATA_NUM_BYTES {3} \
   CONFIG.TDATA_REMAP {tdata[15:0]} \
 ] $axis_subset_converter_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.AUTO_PRIMITIVE {MMCM} \
   CONFIG.CLKOUT1_DRIVES {Buffer} \
   CONFIG.CLKOUT1_JITTER {194.620} \
   CONFIG.CLKOUT1_PHASE_ERROR {376.494} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {262.75} \
   CONFIG.CLKOUT2_DRIVES {Buffer} \
   CONFIG.CLKOUT3_DRIVES {Buffer} \
   CONFIG.CLKOUT4_DRIVES {Buffer} \
   CONFIG.CLKOUT5_DRIVES {Buffer} \
   CONFIG.CLKOUT6_DRIVES {Buffer} \
   CONFIG.CLKOUT7_DRIVES {Buffer} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.MMCM_BANDWIDTH {OPTIMIZED} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {64.375} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {4.375} \
   CONFIG.MMCM_COMPENSATION {AUTO} \
   CONFIG.MMCM_DIVCLK_DIVIDE {14} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_SOURCE {Global_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_RESET {true} \
 ] $clk_wiz_0

  # Create instance: const_high, and set properties
  set const_high [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant const_high ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $const_high

  # Create instance: const_low_4, and set properties
  set const_low_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant const_low_4 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $const_low_4

  # Create instance: const_low_16, and set properties
  set const_low_16 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant const_low_16 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {16} \
 ] $const_low_16

  # Create instance: const_low_24, and set properties
  set const_low_24 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant const_low_24 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {24} \
 ] $const_low_24

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0 ]

  # Create instance: reset_vmix, and set properties
  set reset_vmix [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_vmix ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_vmix

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out v_axi4s_vid_out_0 ]
  set_property -dict [ list \
   CONFIG.C_HAS_ASYNC_CLK {1} \
   CONFIG.C_NATIVE_COMPONENT_WIDTH {8} \
   CONFIG.C_S_AXIS_VIDEO_FORMAT {0} \
   CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_mix_0, and set properties
  set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
  set_property -dict [ list \
   CONFIG.LAYER1_VIDEO_FORMAT {12} \
   CONFIG.LAYER2_VIDEO_FORMAT {12} \
   CONFIG.LAYER3_VIDEO_FORMAT {12} \
   CONFIG.LAYER4_VIDEO_FORMAT {12} \
   CONFIG.LAYER5_ALPHA {true} \
   CONFIG.LAYER5_VIDEO_FORMAT {26} \
   CONFIG.MAX_COLS {3840} \
   CONFIG.MAX_ROWS {2160} \
   CONFIG.NR_LAYERS {6} \
   CONFIG.VIDEO_FORMAT {2} \
 ] $v_mix_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
  set_property -dict [ list \
   CONFIG.GEN_F0_VBLANK_HEND {2008} \
   CONFIG.GEN_F0_VBLANK_HSTART {2008} \
   CONFIG.GEN_F0_VFRAME_SIZE {1125} \
   CONFIG.GEN_F0_VSYNC_HEND {2008} \
   CONFIG.GEN_F0_VSYNC_HSTART {2008} \
   CONFIG.GEN_F0_VSYNC_VEND {1088} \
   CONFIG.GEN_F0_VSYNC_VSTART {1083} \
   CONFIG.GEN_F1_VBLANK_HEND {2008} \
   CONFIG.GEN_F1_VBLANK_HSTART {2008} \
   CONFIG.GEN_F1_VFRAME_SIZE {1125} \
   CONFIG.GEN_F1_VSYNC_HEND {2008} \
   CONFIG.GEN_F1_VSYNC_HSTART {2008} \
   CONFIG.GEN_F1_VSYNC_VEND {1088} \
   CONFIG.GEN_F1_VSYNC_VSTART {1083} \
   CONFIG.GEN_HACTIVE_SIZE {1920} \
   CONFIG.GEN_HFRAME_SIZE {2200} \
   CONFIG.GEN_HSYNC_END {2052} \
   CONFIG.GEN_HSYNC_START {2008} \
   CONFIG.GEN_VACTIVE_SIZE {1080} \
   CONFIG.VIDEO_MODE {1080p} \
   CONFIG.enable_detection {false} \
   CONFIG.max_clocks_per_line {8192} \
 ] $v_tc_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {16} \
   CONFIG.IN1_WIDTH {8} \
   CONFIG.IN2_WIDTH {4} \
   CONFIG.IN3_WIDTH {8} \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_0

  # Create instance: xlslice_15to8, and set properties
  set xlslice_15to8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_15to8 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {16} \
   CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_15to8

  # Create instance: xlslice_7to0, and set properties
  set xlslice_7to0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_7to0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {16} \
   CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_7to0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_ctrl_v_tc] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axi_ctrl_vmix] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axi_ctrl_clk_wiz] [get_bd_intf_pins clk_wiz_0/s_axi_lite]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video1]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_interconnect_0/S01_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video2]
  connect_bd_intf_net -intf_net S02_AXI_1 [get_bd_intf_pins axi_interconnect_0/S02_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video3]
  connect_bd_intf_net -intf_net S03_AXI_1 [get_bd_intf_pins axi_interconnect_0/S03_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video4]
  connect_bd_intf_net -intf_net S04_AXI_1 [get_bd_intf_pins axi_interconnect_0/S04_AXI] [get_bd_intf_pins v_mix_0/m_axi_mm_video5]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
  connect_bd_intf_net -intf_net v_mix_0_m_axis_video [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins v_mix_0/m_axis_video]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_pins clk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK] [get_bd_pins axi_interconnect_0/S04_ACLK] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_mix_0/ap_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins video_clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  connect_bd_net -net const_high_dout [get_bd_pins const_high/dout] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/s_axi_aclken]
  connect_bd_net -net const_low_16_dout [get_bd_pins const_low_16/dout] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net const_low_24_dout [get_bd_pins const_low_24/dout] [get_bd_pins v_mix_0/s_axis_video_TDATA] [get_bd_pins v_mix_0/s_axis_video_TVALID]
  connect_bd_net -net const_low_4_dout [get_bd_pins const_low_4/dout] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net emio_gpio_1 [get_bd_pins emio_gpio] [get_bd_pins reset_vmix/Din]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins ext_reset_in] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
  connect_bd_net -net reset_vmix_Dout [get_bd_pins reset_vmix/Dout] [get_bd_pins v_mix_0/ap_rst_n]
  connect_bd_net -net resetn_1 [get_bd_pins resetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN] [get_bd_pins axi_interconnect_0/S04_ARESETN] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins clk_wiz_0/s_axi_aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins clk_wiz_0/s_axi_aresetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net v_axi4s_vid_out_0_sof_state_out [get_bd_pins v_axi4s_vid_out_0/sof_state_out] [get_bd_pins v_tc_0/sof_state]
  connect_bd_net -net v_axi4s_vid_out_0_vid_active_video [get_bd_pins vid_active_video] [get_bd_pins v_axi4s_vid_out_0/vid_active_video]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_pins v_axi4s_vid_out_0/vid_data] [get_bd_pins xlslice_15to8/Din] [get_bd_pins xlslice_7to0/Din]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_pins vid_hsync] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_pins vid_vsync] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_mix_0_interrupt [get_bd_pins irq_vmix] [get_bd_pins v_mix_0/interrupt]
  connect_bd_net -net v_tc_0_irq [get_bd_pins irq_v_tc] [get_bd_pins v_tc_0/irq]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins vid_data] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_15to8_Dout [get_bd_pins xlconcat_0/In3] [get_bd_pins xlslice_15to8/Dout]
  connect_bd_net -net xlslice_7to0_Dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlslice_7to0/Dout]

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
  set gpio_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_0 ]

  set gpio_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_1 ]

  set gpio_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_2 ]

  set gpio_3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio_3 ]

  set iic_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_0 ]

  set iic_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_1 ]

  set iic_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_2 ]

  set iic_3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_3 ]

  set mipi_phy_if_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0 ]

  set mipi_phy_if_1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_1 ]

  set mipi_phy_if_2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_2 ]

  set mipi_phy_if_3 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_3 ]

  set pci_exp_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_exp_0 ]

  set pci_exp_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pci_exp_1 ]

  set ref_clk_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk_0 ]

  set ref_clk_1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk_1 ]

  set rsvd_gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rsvd_gpio ]


  # Create ports
  set clk_sel [ create_bd_port -dir O -from 1 -to 0 clk_sel ]
  set mipi_0_bg3_pin0_nc [ create_bd_port -dir I mipi_0_bg3_pin0_nc ]
  set mipi_3_bg0_pin0_nc [ create_bd_port -dir I mipi_3_bg0_pin0_nc ]

  # Create instance: axi_ic_ctrl_100, and set properties
  set axi_ic_ctrl_100 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic_ctrl_100 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {9} \
 ] $axi_ic_ctrl_100

  # Create instance: axi_ic_ctrl_250, and set properties
  set axi_ic_ctrl_250 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic_ctrl_250 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {5} \
 ] $axi_ic_ctrl_250

  # Create instance: axi_ic_mcu, and set properties
  set axi_ic_mcu [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_ic_mcu ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_ic_mcu

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc_0 ]
  set_property -dict [ list \
   CONFIG.C_IRQ_CONNECTION {1} \
 ] $axi_intc_0

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_mem_intercon ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {2} \
 ] $axi_mem_intercon

  # Create instance: clk_sel, and set properties
  set clk_sel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant clk_sel ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x01} \
   CONFIG.CONST_WIDTH {2} \
 ] $clk_sel

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {85.183} \
   CONFIG.CLKOUT1_PHASE_ERROR {76.968} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
   CONFIG.CLKOUT2_JITTER {96.285} \
   CONFIG.CLKOUT2_PHASE_ERROR {76.968} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {79.342} \
   CONFIG.CLKOUT3_PHASE_ERROR {76.968} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {300.000} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLKOUT4_JITTER {108.953} \
   CONFIG.CLKOUT4_PHASE_ERROR {76.968} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {50} \
   CONFIG.CLKOUT4_USED {true} \
   CONFIG.CLKOUT5_JITTER {81.912} \
   CONFIG.CLKOUT5_PHASE_ERROR {76.968} \
   CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {250} \
   CONFIG.CLKOUT5_USED {true} \
   CONFIG.CLK_OUT1_PORT {clk_200M} \
   CONFIG.CLK_OUT2_PORT {clk_100M} \
   CONFIG.CLK_OUT3_PORT {clk_300M} \
   CONFIG.CLK_OUT4_PORT {clk_50M} \
   CONFIG.CLK_OUT5_PORT {clk_250M} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {15.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {7.500} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {15} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {5} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {30} \
   CONFIG.MMCM_CLKOUT4_DIVIDE {6} \
   CONFIG.NUM_OUT_CLKS {5} \
   CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
   CONFIG.RESET_PORT {resetn} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_0

  # Create instance: display_pipeline
  create_hier_cell_display_pipeline [current_bd_instance .] display_pipeline

  # Create instance: mipi_0
  create_hier_cell_mipi_0 [current_bd_instance .] mipi_0

  # Create instance: mipi_1
  create_hier_cell_mipi_1 [current_bd_instance .] mipi_1

  # Create instance: mipi_2
  create_hier_cell_mipi_2 [current_bd_instance .] mipi_2

  # Create instance: mipi_3
  create_hier_cell_mipi_3 [current_bd_instance .] mipi_3

  # Create instance: p_intr_concat, and set properties
  set p_intr_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat p_intr_concat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {8} \
 ] $p_intr_concat

  # Create instance: periph_intercon_0, and set properties
  set periph_intercon_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect periph_intercon_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $periph_intercon_0

  # Create instance: ref_clk_0_buf, and set properties
  set ref_clk_0_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf ref_clk_0_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $ref_clk_0_buf

  # Create instance: ref_clk_1_buf, and set properties
  set ref_clk_1_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf ref_clk_1_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $ref_clk_1_buf

  # Create instance: rst_pcie_0_axi_aclk, and set properties
  set rst_pcie_0_axi_aclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_pcie_0_axi_aclk ]

  # Create instance: rst_pcie_1_axi_aclk, and set properties
  set rst_pcie_1_axi_aclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_pcie_1_axi_aclk ]

  # Create instance: rst_ps_100M, and set properties
  set rst_ps_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_ps_100M ]

  # Create instance: rst_ps_axi_100M, and set properties
  set rst_ps_axi_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_ps_axi_100M ]

  # Create instance: rst_video_250M, and set properties
  set rst_video_250M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_video_250M ]

  # Create instance: rst_video_300M, and set properties
  set rst_video_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_video_300M ]

  # Create instance: rsvd_gpio, and set properties
  set rsvd_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio rsvd_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {10} \
 ] $rsvd_gpio

  # Create instance: smartconnect_cams, and set properties
  set smartconnect_cams [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect smartconnect_cams ]
  set_property -dict [ list \
   CONFIG.NUM_SI {4} \
 ] $smartconnect_cams

  # Create instance: vcu
  create_hier_cell_vcu [current_bd_instance .] vcu

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma xdma_0 ]
  set_property -dict [ list \
   CONFIG.BASEADDR {0x00000000} \
   CONFIG.HIGHADDR {0x001FFFFF} \
   CONFIG.INS_LOSS_NYQ {5} \
   CONFIG.PF0_DEVICE_ID_mqdma {9134} \
   CONFIG.PF2_DEVICE_ID_mqdma {9134} \
   CONFIG.PF3_DEVICE_ID_mqdma {9134} \
   CONFIG.axi_addr_width {49} \
   CONFIG.axi_data_width {128_bit} \
   CONFIG.axibar2pciebar_0 {0x0000000540000000} \
   CONFIG.axibar_num {1} \
   CONFIG.axisten_freq {250} \
   CONFIG.dedicate_perst {false} \
   CONFIG.device_port_type {Root_Port_of_PCI_Express_Root_Complex} \
   CONFIG.dma_reset_source_sel {Phy_Ready} \
   CONFIG.en_gt_selection {true} \
   CONFIG.functional_mode {AXI_Bridge} \
   CONFIG.ins_loss_profile {Chip-to-Chip} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.msi_rx_pin_en {TRUE} \
   CONFIG.pcie_blk_locn {X0Y1} \
   CONFIG.pf0_bar0_enabled {false} \
   CONFIG.pf0_bar0_type_mqdma {Memory} \
   CONFIG.pf0_base_class_menu {Bridge_device} \
   CONFIG.pf0_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf0_class_code {060400} \
   CONFIG.pf0_class_code_base {06} \
   CONFIG.pf0_class_code_base_mqdma {06} \
   CONFIG.pf0_class_code_interface {00} \
   CONFIG.pf0_class_code_mqdma {068000} \
   CONFIG.pf0_class_code_sub {04} \
   CONFIG.pf0_device_id {9134} \
   CONFIG.pf0_sriov_bar0_type {Memory} \
   CONFIG.pf0_sub_class_interface_menu {PCI_to_PCI_bridge} \
   CONFIG.pf1_bar0_type_mqdma {Memory} \
   CONFIG.pf1_bar2_64bit {false} \
   CONFIG.pf1_bar2_enabled {false} \
   CONFIG.pf1_bar4_64bit {false} \
   CONFIG.pf1_bar4_enabled {false} \
   CONFIG.pf1_base_class_menu {Bridge_device} \
   CONFIG.pf1_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf1_class_code {060700} \
   CONFIG.pf1_class_code_base {06} \
   CONFIG.pf1_class_code_base_mqdma {06} \
   CONFIG.pf1_class_code_interface {00} \
   CONFIG.pf1_class_code_mqdma {068000} \
   CONFIG.pf1_class_code_sub {07} \
   CONFIG.pf1_sriov_bar0_type {Memory} \
   CONFIG.pf1_sub_class_interface_menu {CardBus_bridge} \
   CONFIG.pf2_bar0_type_mqdma {Memory} \
   CONFIG.pf2_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf2_class_code_base_mqdma {06} \
   CONFIG.pf2_class_code_mqdma {068000} \
   CONFIG.pf2_sriov_bar0_type {Memory} \
   CONFIG.pf3_bar0_type_mqdma {Memory} \
   CONFIG.pf3_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf3_class_code_base_mqdma {06} \
   CONFIG.pf3_class_code_mqdma {068000} \
   CONFIG.pf3_sriov_bar0_type {Memory} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X4} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTH_Quad_225} \
   CONFIG.sys_reset_polarity {ACTIVE_LOW} \
   CONFIG.type1_membase_memlimit_enable {Enabled} \
   CONFIG.type1_prefetchable_membase_memlimit {64bit_Enabled} \
   CONFIG.xdma_axilite_slave {true} \
 ] $xdma_0

  # Create instance: xdma_1, and set properties
  set xdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma xdma_1 ]
  set_property -dict [ list \
   CONFIG.BASEADDR {0x00000000} \
   CONFIG.HIGHADDR {0x001FFFFF} \
   CONFIG.INS_LOSS_NYQ {5} \
   CONFIG.PF0_DEVICE_ID_mqdma {9134} \
   CONFIG.PF2_DEVICE_ID_mqdma {9134} \
   CONFIG.PF3_DEVICE_ID_mqdma {9134} \
   CONFIG.axi_addr_width {49} \
   CONFIG.axi_data_width {128_bit} \
   CONFIG.axibar2pciebar_0 {0x0000000550000000} \
   CONFIG.axibar_num {1} \
   CONFIG.axisten_freq {250} \
   CONFIG.dedicate_perst {false} \
   CONFIG.device_port_type {Root_Port_of_PCI_Express_Root_Complex} \
   CONFIG.dma_reset_source_sel {Phy_Ready} \
   CONFIG.en_gt_selection {true} \
   CONFIG.functional_mode {AXI_Bridge} \
   CONFIG.ins_loss_profile {Chip-to-Chip} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.msi_rx_pin_en {TRUE} \
   CONFIG.pcie_blk_locn {X0Y0} \
   CONFIG.pf0_bar0_enabled {false} \
   CONFIG.pf0_bar0_type_mqdma {Memory} \
   CONFIG.pf0_base_class_menu {Bridge_device} \
   CONFIG.pf0_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf0_class_code {060400} \
   CONFIG.pf0_class_code_base {06} \
   CONFIG.pf0_class_code_base_mqdma {06} \
   CONFIG.pf0_class_code_interface {00} \
   CONFIG.pf0_class_code_mqdma {068000} \
   CONFIG.pf0_class_code_sub {04} \
   CONFIG.pf0_device_id {9134} \
   CONFIG.pf0_sriov_bar0_type {Memory} \
   CONFIG.pf0_sub_class_interface_menu {PCI_to_PCI_bridge} \
   CONFIG.pf1_bar0_type_mqdma {Memory} \
   CONFIG.pf1_bar2_64bit {false} \
   CONFIG.pf1_bar2_enabled {false} \
   CONFIG.pf1_bar4_64bit {false} \
   CONFIG.pf1_bar4_enabled {false} \
   CONFIG.pf1_base_class_menu {Bridge_device} \
   CONFIG.pf1_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf1_class_code {060700} \
   CONFIG.pf1_class_code_base {06} \
   CONFIG.pf1_class_code_base_mqdma {06} \
   CONFIG.pf1_class_code_interface {00} \
   CONFIG.pf1_class_code_mqdma {068000} \
   CONFIG.pf1_class_code_sub {07} \
   CONFIG.pf1_sriov_bar0_type {Memory} \
   CONFIG.pf1_sub_class_interface_menu {CardBus_bridge} \
   CONFIG.pf2_bar0_type_mqdma {Memory} \
   CONFIG.pf2_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf2_class_code_base_mqdma {06} \
   CONFIG.pf2_class_code_mqdma {068000} \
   CONFIG.pf2_sriov_bar0_type {Memory} \
   CONFIG.pf3_bar0_type_mqdma {Memory} \
   CONFIG.pf3_base_class_menu_mqdma {Bridge_device} \
   CONFIG.pf3_class_code_base_mqdma {06} \
   CONFIG.pf3_class_code_mqdma {068000} \
   CONFIG.pf3_sriov_bar0_type {Memory} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X4} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTH_Quad_224} \
   CONFIG.sys_reset_polarity {ACTIVE_LOW} \
   CONFIG.type1_membase_memlimit_enable {Enabled} \
   CONFIG.type1_prefetchable_membase_memlimit {64bit_Enabled} \
   CONFIG.xdma_axilite_slave {true} \
 ] $xdma_1

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {22} \
 ] $xlconcat_0

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0 ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS33} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_18_DIRECTION {inout} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_19_DIRECTION {inout} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_20_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {out} \
   CONFIG.PSU_MIO_22_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_24_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_25_DIRECTION {inout} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_28_SLEW {fast} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_30_SLEW {fast} \
   CONFIG.PSU_MIO_31_DIRECTION {out} \
   CONFIG.PSU_MIO_31_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_32_DIRECTION {out} \
   CONFIG.PSU_MIO_32_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_33_DIRECTION {in} \
   CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_33_SLEW {fast} \
   CONFIG.PSU_MIO_34_DIRECTION {in} \
   CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_34_SLEW {fast} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_36_DIRECTION {inout} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_37_DIRECTION {inout} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_38_POLARITY {Default} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_POLARITY {Default} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_POLARITY {Default} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_POLARITY {Default} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_POLARITY {Default} \
   CONFIG.PSU_MIO_43_DIRECTION {inout} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_44_DIRECTION {inout} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_52_SLEW {fast} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_53_SLEW {fast} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_55_SLEW {fast} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_6_POLARITY {Default} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_70_SLEW {fast} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_71_SLEW {fast} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_72_SLEW {fast} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_73_SLEW {fast} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_74_SLEW {fast} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_75_SLEW {fast} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {\
Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad\
SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI\
Flash#Quad SPI Flash#Quad SPI Flash#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD\
0#SD 0#GPIO0 MIO#I2C 1#I2C 1#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#PCIE#UART 1#UART\
1#UART 0#UART 0#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1\
MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB\
0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem\
3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {\
sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#sdio0_data_out[0]#sdio0_data_out[1]#sdio0_data_out[2]#sdio0_data_out[3]#sdio0_data_out[4]#sdio0_data_out[5]#sdio0_data_out[6]#sdio0_data_out[7]#sdio0_cmd_out#sdio0_clk_out#gpio0[23]#scl_out#sda_out#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#reset_n#txd#rxd#rxd#txd#gpio1[36]#gpio1[37]#gpio1[38]#gpio1[39]#gpio1[40]#gpio1[41]#gpio1[42]#gpio1[43]#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {4} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1199.988037} \
   CONFIG.PSU__AFI0_COHERENCY {0} \
   CONFIG.PSU__AFI1_COHERENCY {0} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1099.989014} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1100} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {66} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {549.994507} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {550} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.999750} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {16} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.666401} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {549.994507} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {550} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {399.996002} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {475} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {199.998001} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {199.998001} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {16} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__CWL {16} \
   CONFIG.PSU__DDRC__DDR3L_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ENABLE {1} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__LPDDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
   CONFIG.PSU__DDRC__SB_TARGET {16-16-16} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400R} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {32} \
   CONFIG.PSU__DDRC__T_RC {45.32} \
   CONFIG.PSU__DDRC__T_RCD {16} \
   CONFIG.PSU__DDRC__T_RP {16} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {600.000} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane3} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {0} \
   CONFIG.PSU__DISPLAYPORT__LANE1__IO {<Select>} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Single Higher} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
   CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {95} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 24 .. 25} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {64} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PCIE__BAR0_64BIT {0} \
   CONFIG.PSU__PCIE__BAR0_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR0_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR0_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR1_64BIT {0} \
   CONFIG.PSU__PCIE__BAR1_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR1_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR1_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR2_64BIT {0} \
   CONFIG.PSU__PCIE__BAR2_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR2_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR2_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR3_64BIT {0} \
   CONFIG.PSU__PCIE__BAR3_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR3_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR3_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR4_64BIT {0} \
   CONFIG.PSU__PCIE__BAR4_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR4_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR4_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR5_64BIT {0} \
   CONFIG.PSU__PCIE__BAR5_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR5_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR5_VAL {0x0} \
   CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \
   CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {0x0} \
   CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x4} \
   CONFIG.PSU__PCIE__CLASS_CODE_VALUE {0x60400} \
   CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {1} \
   CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \
   CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {Root Port} \
   CONFIG.PSU__PCIE__EROM_ENABLE {0} \
   CONFIG.PSU__PCIE__EROM_VAL {0x0} \
   CONFIG.PSU__PCIE__LANE0__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE0__IO {GT Lane0} \
   CONFIG.PSU__PCIE__LANE1__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE2__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE3__ENABLE {0} \
   CONFIG.PSU__PCIE__LINK_SPEED {5.0 Gb/s} \
   CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {x1} \
   CONFIG.PSU__PCIE__MAX_PAYLOAD_SIZE {256 bytes} \
   CONFIG.PSU__PCIE__MSIX_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
   CONFIG.PSU__PCIE__MSIX_PBA_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_PBA_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_SIZE {0} \
   CONFIG.PSU__PCIE__MSI_64BIT_ADDR_CAPABLE {0} \
   CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {MIO 31} \
   CONFIG.PSU__PCIE__REF_CLK_FREQ {100} \
   CONFIG.PSU__PCIE__REF_CLK_SEL {Ref Clk0} \
   CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
   CONFIG.PSU__PCIE__REVISION_ID {0x0} \
   CONFIG.PSU__PCIE__SUBSYSTEM_ID {0x7} \
   CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {0x10EE} \
   CONFIG.PSU__PCIE__VENDOR_ID {0x10EE} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PROTECTION__MASTERS {\
USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;1|S_AXI_HPC1_FPD:NA;1|S_AXI_HPC0_FPD:NA;1|S_AXI_HP3_FPD:NA;1|S_AXI_HP2_FPD:NA;1|S_AXI_HP1_FPD:NA;1|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;1|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;1|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES {\
LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;1|FPD;PCIE_LOW;E0000000;EFFFFFFF;1|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;1|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;1|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;1|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;1|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;0|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1} \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane1} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__SAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP5__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP6__DATA_WIDTH {128} \
   CONFIG.PSU__SD0_COHERENCY {0} \
   CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD0__CLK_100_SDR_OTAP_DLY {0x0} \
   CONFIG.PSU__SD0__CLK_200_SDR_OTAP_DLY {0x3} \
   CONFIG.PSU__SD0__CLK_50_DDR_ITAP_DLY {0x12} \
   CONFIG.PSU__SD0__CLK_50_DDR_OTAP_DLY {0x6} \
   CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x15} \
   CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x6} \
   CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD0__GRP_CD__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
   CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__CLK_100_SDR_OTAP_DLY {0x0} \
   CONFIG.PSU__SD1__CLK_200_SDR_OTAP_DLY {0x0} \
   CONFIG.PSU__SD1__CLK_50_DDR_ITAP_DLY {0x0} \
   CONFIG.PSU__SD1__CLK_50_DDR_OTAP_DLY {0x0} \
   CONFIG.PSU__SD1__CLK_50_SDR_ITAP_DLY {0x15} \
   CONFIG.PSU__SD1__CLK_50_SDR_OTAP_DLY {0x5} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {4Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 34 .. 35} \
   CONFIG.PSU__UART1__BAUD_RATE {115200} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 32 .. 33} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {52} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__IRQ1 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {1} \
   CONFIG.PSU__USE__M_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP0 {1} \
   CONFIG.PSU__USE__S_AXI_GP1 {1} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP3 {1} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.PSU__USE__S_AXI_GP5 {1} \
   CONFIG.PSU__USE__S_AXI_GP6 {1} \
   CONFIG.PSU__USE__VIDEO {1} \
 ] $zynq_ultra_ps_e_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M00_AXI [get_bd_intf_pins axi_ic_ctrl_100/M00_AXI] [get_bd_intf_pins axi_intc_0/s_axi]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M01_AXI [get_bd_intf_pins axi_ic_ctrl_100/M01_AXI] [get_bd_intf_pins rsvd_gpio/S_AXI]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M02_AXI [get_bd_intf_pins axi_ic_ctrl_100/M02_AXI] [get_bd_intf_pins mipi_0/S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M03_AXI [get_bd_intf_pins axi_ic_ctrl_100/M03_AXI] [get_bd_intf_pins mipi_1/S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M04_AXI [get_bd_intf_pins axi_ic_ctrl_100/M04_AXI] [get_bd_intf_pins mipi_2/S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M05_AXI [get_bd_intf_pins axi_ic_ctrl_100/M05_AXI] [get_bd_intf_pins mipi_3/S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M06_AXI [get_bd_intf_pins axi_ic_ctrl_100/M06_AXI] [get_bd_intf_pins vcu/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M07_AXI [get_bd_intf_pins axi_ic_ctrl_100/M07_AXI] [get_bd_intf_pins display_pipeline/s_axi_ctrl_clk_wiz]
  connect_bd_intf_net -intf_net axi_ic_ctrl_100_M08_AXI [get_bd_intf_pins axi_ic_ctrl_100/M08_AXI] [get_bd_intf_pins display_pipeline/s_axi_ctrl_v_tc]
  connect_bd_intf_net -intf_net axi_ic_ctrl_250_M00_AXI [get_bd_intf_pins axi_ic_ctrl_250/M00_AXI] [get_bd_intf_pins mipi_0/S_AXI_VIDEO]
  connect_bd_intf_net -intf_net axi_ic_ctrl_250_M01_AXI [get_bd_intf_pins axi_ic_ctrl_250/M01_AXI] [get_bd_intf_pins mipi_1/S_AXI_VIDEO]
  connect_bd_intf_net -intf_net axi_ic_ctrl_250_M02_AXI [get_bd_intf_pins axi_ic_ctrl_250/M02_AXI] [get_bd_intf_pins mipi_2/S_AXI_VIDEO]
  connect_bd_intf_net -intf_net axi_ic_ctrl_250_M03_AXI [get_bd_intf_pins axi_ic_ctrl_250/M03_AXI] [get_bd_intf_pins mipi_3/S_AXI_VIDEO]
  connect_bd_intf_net -intf_net axi_ic_ctrl_250_M04_AXI [get_bd_intf_pins axi_ic_ctrl_250/M04_AXI] [get_bd_intf_pins display_pipeline/s_axi_ctrl_vmix]
  connect_bd_intf_net -intf_net axi_ic_mcu_M00_AXI [get_bd_intf_pins axi_ic_mcu/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_LPD]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net display_pipeline_M00_AXI [get_bd_intf_pins display_pipeline/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net mipi_0_GPIO [get_bd_intf_ports gpio_0] [get_bd_intf_pins mipi_0/GPIO]
  connect_bd_intf_net -intf_net mipi_0_IIC [get_bd_intf_ports iic_0] [get_bd_intf_pins mipi_0/IIC]
  connect_bd_intf_net -intf_net mipi_0_m_axi_mm_video [get_bd_intf_pins mipi_0/m_axi_mm_video] [get_bd_intf_pins smartconnect_cams/S00_AXI]
  connect_bd_intf_net -intf_net mipi_1_GPIO [get_bd_intf_ports gpio_1] [get_bd_intf_pins mipi_1/GPIO]
  connect_bd_intf_net -intf_net mipi_1_IIC [get_bd_intf_ports iic_1] [get_bd_intf_pins mipi_1/IIC]
  connect_bd_intf_net -intf_net mipi_1_m_axi_mm_video [get_bd_intf_pins mipi_1/m_axi_mm_video] [get_bd_intf_pins smartconnect_cams/S01_AXI]
  connect_bd_intf_net -intf_net mipi_2_GPIO [get_bd_intf_ports gpio_2] [get_bd_intf_pins mipi_2/GPIO]
  connect_bd_intf_net -intf_net mipi_2_IIC [get_bd_intf_ports iic_2] [get_bd_intf_pins mipi_2/IIC]
  connect_bd_intf_net -intf_net mipi_2_m_axi_mm_video [get_bd_intf_pins mipi_2/m_axi_mm_video] [get_bd_intf_pins smartconnect_cams/S02_AXI]
  connect_bd_intf_net -intf_net mipi_3_GPIO [get_bd_intf_ports gpio_3] [get_bd_intf_pins mipi_3/GPIO]
  connect_bd_intf_net -intf_net mipi_3_IIC [get_bd_intf_ports iic_3] [get_bd_intf_pins mipi_3/IIC]
  connect_bd_intf_net -intf_net mipi_3_m_axi_mm_video [get_bd_intf_pins mipi_3/m_axi_mm_video] [get_bd_intf_pins smartconnect_cams/S03_AXI]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_ports mipi_phy_if_0] [get_bd_intf_pins mipi_0/mipi_phy_if]
  connect_bd_intf_net -intf_net mipi_phy_if_1_1 [get_bd_intf_ports mipi_phy_if_1] [get_bd_intf_pins mipi_1/mipi_phy_if]
  connect_bd_intf_net -intf_net mipi_phy_if_2_1 [get_bd_intf_ports mipi_phy_if_2] [get_bd_intf_pins mipi_2/mipi_phy_if]
  connect_bd_intf_net -intf_net mipi_phy_if_3_1 [get_bd_intf_ports mipi_phy_if_3] [get_bd_intf_pins mipi_3/mipi_phy_if]
  connect_bd_intf_net -intf_net periph_intercon_0_M00_AXI [get_bd_intf_pins periph_intercon_0/M00_AXI] [get_bd_intf_pins xdma_0/S_AXI_B]
  connect_bd_intf_net -intf_net periph_intercon_0_M01_AXI [get_bd_intf_pins periph_intercon_0/M01_AXI] [get_bd_intf_pins xdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net periph_intercon_0_M02_AXI [get_bd_intf_pins periph_intercon_0/M02_AXI] [get_bd_intf_pins xdma_1/S_AXI_B]
  connect_bd_intf_net -intf_net periph_intercon_0_M03_AXI [get_bd_intf_pins periph_intercon_0/M03_AXI] [get_bd_intf_pins xdma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net ref_clk_0_1 [get_bd_intf_ports ref_clk_0] [get_bd_intf_pins ref_clk_0_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net ref_clk_1_1 [get_bd_intf_ports ref_clk_1] [get_bd_intf_pins ref_clk_1_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net rsvd_gpio_GPIO [get_bd_intf_ports rsvd_gpio] [get_bd_intf_pins rsvd_gpio/GPIO]
  connect_bd_intf_net -intf_net smartconnect_cams_M00_AXI [get_bd_intf_pins smartconnect_cams/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net vcu_M00_AXI_VCU_DEC [get_bd_intf_pins vcu/M00_AXI_VCU_DEC] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net vcu_M00_AXI_VCU_EN [get_bd_intf_pins vcu/M00_AXI_VCU_EN] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net vcu_M_AXI_VCU_MCU [get_bd_intf_pins axi_ic_mcu/S00_AXI] [get_bd_intf_pins vcu/M_AXI_VCU_MCU]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_B [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins xdma_0/M_AXI_B]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pci_exp_0] [get_bd_intf_pins xdma_0/pcie_mgt]
  connect_bd_intf_net -intf_net xdma_1_M_AXI_B [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins xdma_1/M_AXI_B]
  connect_bd_intf_net -intf_net xdma_1_pcie_mgt [get_bd_intf_ports pci_exp_1] [get_bd_intf_pins xdma_1/pcie_mgt]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins axi_ic_ctrl_250/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_LPD [get_bd_intf_pins axi_ic_ctrl_100/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_LPD]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM1_FPD [get_bd_intf_pins periph_intercon_0/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM1_FPD]

  # Create port connections
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
  connect_bd_net -net clk_sel_dout [get_bd_ports clk_sel] [get_bd_pins clk_sel/dout]
  connect_bd_net -net clk_wiz_0_clk_100M [get_bd_pins axi_ic_ctrl_100/ACLK] [get_bd_pins axi_ic_ctrl_100/M00_ACLK] [get_bd_pins axi_ic_ctrl_100/M01_ACLK] [get_bd_pins axi_ic_ctrl_100/M02_ACLK] [get_bd_pins axi_ic_ctrl_100/M03_ACLK] [get_bd_pins axi_ic_ctrl_100/M04_ACLK] [get_bd_pins axi_ic_ctrl_100/M05_ACLK] [get_bd_pins axi_ic_ctrl_100/M06_ACLK] [get_bd_pins axi_ic_ctrl_100/M07_ACLK] [get_bd_pins axi_ic_ctrl_100/M08_ACLK] [get_bd_pins axi_ic_ctrl_100/S00_ACLK] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_100M] [get_bd_pins display_pipeline/s_axi_aclk] [get_bd_pins mipi_0/s_axi_lite_aclk] [get_bd_pins mipi_1/s_axi_lite_aclk] [get_bd_pins mipi_2/s_axi_lite_aclk] [get_bd_pins mipi_3/s_axi_lite_aclk] [get_bd_pins rst_ps_axi_100M/slowest_sync_clk] [get_bd_pins rsvd_gpio/s_axi_aclk] [get_bd_pins vcu/s_axi_lite_aclk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk]
  connect_bd_net -net clk_wiz_0_clk_200M [get_bd_pins clk_wiz_0/clk_200M] [get_bd_pins mipi_0/dphy_clk_200M] [get_bd_pins mipi_1/dphy_clk_200M] [get_bd_pins mipi_2/dphy_clk_200M] [get_bd_pins mipi_3/dphy_clk_200M]
  connect_bd_net -net clk_wiz_0_clk_250M [get_bd_pins axi_ic_ctrl_250/ACLK] [get_bd_pins axi_ic_ctrl_250/M00_ACLK] [get_bd_pins axi_ic_ctrl_250/M01_ACLK] [get_bd_pins axi_ic_ctrl_250/M02_ACLK] [get_bd_pins axi_ic_ctrl_250/M03_ACLK] [get_bd_pins axi_ic_ctrl_250/M04_ACLK] [get_bd_pins axi_ic_ctrl_250/S00_ACLK] [get_bd_pins axi_ic_mcu/ACLK] [get_bd_pins axi_ic_mcu/M00_ACLK] [get_bd_pins axi_ic_mcu/S00_ACLK] [get_bd_pins clk_wiz_0/clk_250M] [get_bd_pins display_pipeline/clk] [get_bd_pins mipi_0/video_aclk] [get_bd_pins mipi_1/video_aclk] [get_bd_pins mipi_2/video_aclk] [get_bd_pins mipi_3/video_aclk] [get_bd_pins rst_video_250M/slowest_sync_clk] [get_bd_pins smartconnect_cams/aclk] [get_bd_pins vcu/m_axi_dec_aclk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxi_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp1_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp3_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihpc0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihpc1_fpd_aclk]
  connect_bd_net -net clk_wiz_0_clk_300M [get_bd_pins clk_wiz_0/clk_300M] [get_bd_pins rst_video_300M/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_clk_50M [get_bd_pins clk_wiz_0/clk_50M] [get_bd_pins vcu/pll_ref_clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins rst_ps_axi_100M/dcm_locked] [get_bd_pins rst_video_250M/dcm_locked] [get_bd_pins rst_video_300M/dcm_locked]
  connect_bd_net -net display_pipeline_irq_v_tc [get_bd_pins display_pipeline/irq_v_tc] [get_bd_pins p_intr_concat/In1]
  connect_bd_net -net display_pipeline_irq_vmix [get_bd_pins display_pipeline/irq_vmix] [get_bd_pins p_intr_concat/In2]
  connect_bd_net -net display_pipeline_vid_active_video [get_bd_pins display_pipeline/vid_active_video] [get_bd_pins zynq_ultra_ps_e_0/dp_live_video_in_de]
  connect_bd_net -net display_pipeline_vid_data [get_bd_pins display_pipeline/vid_data] [get_bd_pins zynq_ultra_ps_e_0/dp_live_video_in_pixel1]
  connect_bd_net -net display_pipeline_vid_hsync [get_bd_pins display_pipeline/vid_hsync] [get_bd_pins zynq_ultra_ps_e_0/dp_live_video_in_hsync]
  connect_bd_net -net display_pipeline_vid_vsync [get_bd_pins display_pipeline/vid_vsync] [get_bd_pins zynq_ultra_ps_e_0/dp_live_video_in_vsync]
  connect_bd_net -net display_pipeline_video_clk [get_bd_pins display_pipeline/video_clk] [get_bd_pins zynq_ultra_ps_e_0/dp_video_in_clk]
  connect_bd_net -net mipi_0_bg3_pin0_nc_1 [get_bd_ports mipi_0_bg3_pin0_nc] [get_bd_pins mipi_0/mipi_0_bg3_pin0_nc]
  connect_bd_net -net mipi_0_frmbufwr_irq [get_bd_pins mipi_0/frmbufwr_irq] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net mipi_0_iic2intc_irpt [get_bd_pins mipi_0/iic2intc_irpt] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net mipi_0_isppipeline_irq [get_bd_pins mipi_0/isppipeline_irq] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net mipi_0_mipi_sub_irq [get_bd_pins mipi_0/mipi_sub_irq] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net mipi_1_frmbufwr_irq [get_bd_pins mipi_1/frmbufwr_irq] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net mipi_1_iic2intc_irpt [get_bd_pins mipi_1/iic2intc_irpt] [get_bd_pins xlconcat_0/In7]
  connect_bd_net -net mipi_1_isppipeline_irq [get_bd_pins mipi_1/isppipeline_irq] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net mipi_1_mipi_sub_irq [get_bd_pins mipi_1/mipi_sub_irq] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net mipi_2_frmbufwr_irq [get_bd_pins mipi_2/frmbufwr_irq] [get_bd_pins xlconcat_0/In10]
  connect_bd_net -net mipi_2_iic2intc_irpt [get_bd_pins mipi_2/iic2intc_irpt] [get_bd_pins xlconcat_0/In11]
  connect_bd_net -net mipi_2_isppipeline_irq [get_bd_pins mipi_2/isppipeline_irq] [get_bd_pins xlconcat_0/In9]
  connect_bd_net -net mipi_2_mipi_sub_irq [get_bd_pins mipi_2/mipi_sub_irq] [get_bd_pins xlconcat_0/In8]
  connect_bd_net -net mipi_3_bg0_pin0_nc_1 [get_bd_ports mipi_3_bg0_pin0_nc] [get_bd_pins mipi_3/mipi_3_bg0_pin0_nc]
  connect_bd_net -net mipi_3_frmbufwr_irq [get_bd_pins mipi_3/frmbufwr_irq] [get_bd_pins xlconcat_0/In14]
  connect_bd_net -net mipi_3_iic2intc_irpt [get_bd_pins mipi_3/iic2intc_irpt] [get_bd_pins xlconcat_0/In15]
  connect_bd_net -net mipi_3_isppipeline_irq [get_bd_pins mipi_3/isppipeline_irq] [get_bd_pins xlconcat_0/In13]
  connect_bd_net -net mipi_3_mipi_sub_irq [get_bd_pins mipi_3/mipi_sub_irq] [get_bd_pins xlconcat_0/In12]
  connect_bd_net -net p_intr_concat_dout [get_bd_pins p_intr_concat/dout] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq1]
  connect_bd_net -net ref_clk_0_buf_IBUF_DS_ODIV2 [get_bd_pins ref_clk_0_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net ref_clk_0_buf_IBUF_OUT [get_bd_pins ref_clk_0_buf/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net ref_clk_1_buf_IBUF_DS_ODIV2 [get_bd_pins ref_clk_1_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_1/sys_clk]
  connect_bd_net -net ref_clk_1_buf_IBUF_OUT [get_bd_pins ref_clk_1_buf/IBUF_OUT] [get_bd_pins xdma_1/sys_clk_gt]
  connect_bd_net -net rst_ps_100M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/M01_ARESETN] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins display_pipeline/ext_reset_in] [get_bd_pins periph_intercon_0/S00_ARESETN] [get_bd_pins rst_ps_100M/peripheral_aresetn] [get_bd_pins rst_ps_axi_100M/ext_reset_in] [get_bd_pins rst_video_250M/ext_reset_in] [get_bd_pins rst_video_300M/ext_reset_in]
  connect_bd_net -net rst_ps_axi_100M_interconnect_aresetn [get_bd_pins axi_ic_ctrl_100/ARESETN] [get_bd_pins rst_ps_axi_100M/interconnect_aresetn]
  connect_bd_net -net rst_ps_axi_100M_peripheral_aresetn [get_bd_pins axi_ic_ctrl_100/M00_ARESETN] [get_bd_pins axi_ic_ctrl_100/M01_ARESETN] [get_bd_pins axi_ic_ctrl_100/M02_ARESETN] [get_bd_pins axi_ic_ctrl_100/M03_ARESETN] [get_bd_pins axi_ic_ctrl_100/M04_ARESETN] [get_bd_pins axi_ic_ctrl_100/M05_ARESETN] [get_bd_pins axi_ic_ctrl_100/M06_ARESETN] [get_bd_pins axi_ic_ctrl_100/M07_ARESETN] [get_bd_pins axi_ic_ctrl_100/M08_ARESETN] [get_bd_pins axi_ic_ctrl_100/S00_ARESETN] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins display_pipeline/s_axi_aresetn] [get_bd_pins mipi_0/aresetn] [get_bd_pins mipi_1/aresetn] [get_bd_pins mipi_2/aresetn] [get_bd_pins mipi_3/aresetn] [get_bd_pins rst_ps_axi_100M/peripheral_aresetn] [get_bd_pins rsvd_gpio/s_axi_aresetn]
  connect_bd_net -net rst_video_250M_interconnect_aresetn [get_bd_pins axi_ic_ctrl_250/ARESETN] [get_bd_pins axi_ic_mcu/ARESETN] [get_bd_pins rst_video_250M/interconnect_aresetn]
  connect_bd_net -net rst_video_250M_peripheral_aresetn [get_bd_pins axi_ic_ctrl_250/M00_ARESETN] [get_bd_pins axi_ic_ctrl_250/M01_ARESETN] [get_bd_pins axi_ic_ctrl_250/M02_ARESETN] [get_bd_pins axi_ic_ctrl_250/M03_ARESETN] [get_bd_pins axi_ic_ctrl_250/M04_ARESETN] [get_bd_pins axi_ic_ctrl_250/S00_ARESETN] [get_bd_pins axi_ic_mcu/M00_ARESETN] [get_bd_pins axi_ic_mcu/S00_ARESETN] [get_bd_pins display_pipeline/resetn] [get_bd_pins mipi_0/video_aresetn] [get_bd_pins mipi_1/video_aresetn] [get_bd_pins mipi_2/video_aresetn] [get_bd_pins mipi_3/video_aresetn] [get_bd_pins rst_video_250M/peripheral_aresetn] [get_bd_pins smartconnect_cams/aresetn] [get_bd_pins vcu/aresetn]
  connect_bd_net -net vcu_vcu_host_interrupt [get_bd_pins p_intr_concat/In0] [get_bd_pins vcu/vcu_host_interrupt]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins periph_intercon_0/ACLK] [get_bd_pins periph_intercon_0/M00_ACLK] [get_bd_pins periph_intercon_0/M01_ACLK] [get_bd_pins rst_pcie_0_axi_aclk/slowest_sync_clk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins periph_intercon_0/ARESETN] [get_bd_pins periph_intercon_0/M00_ARESETN] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net xdma_0_axi_ctl_aresetn [get_bd_pins periph_intercon_0/M01_ARESETN] [get_bd_pins rst_pcie_0_axi_aclk/ext_reset_in] [get_bd_pins xdma_0/axi_ctl_aresetn]
  connect_bd_net -net xdma_0_interrupt_out [get_bd_pins xdma_0/interrupt_out] [get_bd_pins xlconcat_0/In16]
  connect_bd_net -net xdma_0_interrupt_out_msi_vec0to31 [get_bd_pins xdma_0/interrupt_out_msi_vec0to31] [get_bd_pins xlconcat_0/In18]
  connect_bd_net -net xdma_0_interrupt_out_msi_vec32to63 [get_bd_pins xdma_0/interrupt_out_msi_vec32to63] [get_bd_pins xlconcat_0/In19]
  connect_bd_net -net xdma_1_axi_aclk [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins periph_intercon_0/M02_ACLK] [get_bd_pins periph_intercon_0/M03_ACLK] [get_bd_pins rst_pcie_1_axi_aclk/slowest_sync_clk] [get_bd_pins xdma_1/axi_aclk]
  connect_bd_net -net xdma_1_axi_aresetn [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins periph_intercon_0/M02_ARESETN] [get_bd_pins xdma_1/axi_aresetn]
  connect_bd_net -net xdma_1_axi_ctl_aresetn [get_bd_pins periph_intercon_0/M03_ARESETN] [get_bd_pins rst_pcie_1_axi_aclk/ext_reset_in] [get_bd_pins xdma_1/axi_ctl_aresetn]
  connect_bd_net -net xdma_1_interrupt_out [get_bd_pins xdma_1/interrupt_out] [get_bd_pins xlconcat_0/In17]
  connect_bd_net -net xdma_1_interrupt_out_msi_vec0to31 [get_bd_pins xdma_1/interrupt_out_msi_vec0to31] [get_bd_pins xlconcat_0/In20]
  connect_bd_net -net xdma_1_interrupt_out_msi_vec32to63 [get_bd_pins xdma_1/interrupt_out_msi_vec32to63] [get_bd_pins xlconcat_0/In21]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net zynq_ultra_ps_e_0_emio_gpio_o [get_bd_pins display_pipeline/emio_gpio] [get_bd_pins mipi_0/emio_gpio] [get_bd_pins mipi_1/emio_gpio] [get_bd_pins mipi_2/emio_gpio] [get_bd_pins mipi_3/emio_gpio] [get_bd_pins vcu/Din] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/M01_ACLK] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins periph_intercon_0/S00_ACLK] [get_bd_pins rst_ps_100M/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm1_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins rst_ps_100M/ext_reset_in] [get_bd_pins xdma_0/sys_rst_n] [get_bd_pins xdma_1/sys_rst_n] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces xdma_1/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces xdma_1/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces xdma_1/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces xdma_1/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces xdma_1/M_AXI_B] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] -force
  assign_bd_address -offset 0x80040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x800A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80070000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x800B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x80020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs display_pipeline/clk_wiz_0/s_axi_lite/Reg] -force
  assign_bd_address -offset 0xA0110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/isppipeline/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/isppipeline/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0150000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/isppipeline/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/isppipeline/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x80001000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x80002000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x80003000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
  assign_bd_address -offset 0x800C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs rsvd_gpio/S_AXI/Reg] -force
  assign_bd_address -offset 0xA0120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/v_frmbuf_wr/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/v_frmbuf_wr/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0160000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/v_frmbuf_wr/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0180000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/v_frmbuf_wr/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0100000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs display_pipeline/v_mix_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0xA0000000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_0/v_proc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA0040000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_1/v_proc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA0080000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_2/v_proc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0xA00C0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_3/v_proc/s_axi_ctrl/Reg] -force
  assign_bd_address -offset 0x80030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs display_pipeline/v_tc_0/ctrl/Reg] -force
  assign_bd_address -offset 0x80100000 -range 0x00100000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs vcu/vcu_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x000540000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs xdma_0/S_AXI_B/BAR0] -force
  assign_bd_address -offset 0x000500000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs xdma_0/S_AXI_LITE/CTL0] -force
  assign_bd_address -offset 0x000550000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs xdma_1/S_AXI_B/BAR0] -force
  assign_bd_address -offset 0x000520000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs xdma_1/S_AXI_LITE/CTL0] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_0/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces mipi_0/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces mipi_0/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_1/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces mipi_1/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces mipi_1/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_2/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces mipi_2/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces mipi_2/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi_3/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces mipi_3/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces mipi_3/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/Code] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/Code] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/Code] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/Code] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/Code] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/DecData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData0] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] -force
  assign_bd_address -offset 0x000800000000 -range 0x000800000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] -force
  assign_bd_address -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_PCIE_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces vcu/vcu_0/EncData1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces display_pipeline/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces mipi_0/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces mipi_0/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces mipi_1/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces mipi_1/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces mipi_2/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces mipi_2/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces mipi_3/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces mipi_3/v_frmbuf_wr/Data_m_axi_mm_video] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM_NAME {avnet-tria:uz7ev:uz7ev_evcc_camerafmc:1.0} [get_files [current_bd_design].bd]
  set_property PFM.AXI_PORT {M09_AXI {memport "M_AXI_GP"} M10_AXI {memport "M_AXI_GP"} M11_AXI {memport "M_AXI_GP"} M12_AXI {memport "M_AXI_GP"} M13_AXI {memport "M_AXI_GP"} M14_AXI {memport "M_AXI_GP"} M15_AXI {memport "M_AXI_GP"}} [get_bd_cells /axi_ic_ctrl_100]
  set_property PFM.CLOCK {  clk_100M {id "3" is_default "false" proc_sys_reset "/rst_ps_axi_100M" status "fixed" freq_hz "149985000"}  clk_300M {id "4" is_default "false" proc_sys_reset "/rst_video_300M" status "fixed" freq_hz "299970000"}  clk_250M {id "9" is_default "true" proc_sys_reset "/rst_video_250M" status "fixed" freq_hz "249975000"}  } [get_bd_cells /clk_wiz_0]
  set_property PFM.IRQ {  In6 {id "0" is_range "true"}  In7 {id "1" is_range "true"}  } [get_bd_cells /p_intr_concat]
  set_property PFM.AXI_PORT {  S_AXI_HPC1_FPD {memport "S_AXI_HP" sptag "HPC1" memory "HPC1_DDR_LOW" is_range "false"}  } [get_bd_cells /zynq_ultra_ps_e_0]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


