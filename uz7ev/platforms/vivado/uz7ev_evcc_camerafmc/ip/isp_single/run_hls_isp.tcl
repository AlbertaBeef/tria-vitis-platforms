# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

source settings.tcl

#set VITIS_LIBS ../../Vitis_Libraries/vision/
set VITIS_LIBS ../../../../../../common/Vitis_Libraries/vision/

set PROJ "isppipeline.prj"
set SOLN "sol1"

if {![info exists CLKP]} {
  set CLKP 3.3
}

if {![info exists XPART]} {
  set xczu7ev-fbvb900-1-i
}

open_project -reset $PROJ

add_files "${VITIS_LIBS}/L1/examples/isppipeline/xf_isp_accel.cpp ${VITIS_LIBS}/L1/examples/isppipeline/xf_isp_types.h" -cflags "-I ${VITIS_LIBS}/L1/include -I ./build_isp -I ./ -D__SDSVHLS__ -std=c++0x" -csimflags "-I ${VITIS_LIBS}/L1/include -I ./build_isp -I ./ -D__SDSVHLS__ -std=c++0x"
set_top ISPPipeline_accel

open_solution -reset $SOLN

set_part $XPART
create_clock -period $CLKP

csynth_design
export_design -rtl verilog -format ip_catalog

exit
