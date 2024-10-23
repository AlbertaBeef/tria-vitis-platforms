# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# parsing options
set options [dict create {*}$argv]

set xsa_path [dict get $options xsa_path]
set platform_name [dict get $options platform_name]
set emu_xsa_path [dict get $options emu_xsa_path]
set platform_out [dict get $options platform_out]
set boot_dir_path [dict get $options boot_dir_path]
set img_dir_path [dict get $options img_dir_path]

set plat_arg [list]
if {$xsa_path ne "" && [file exists $xsa_path]} {
  lappend plat_arg -hw
  lappend plat_arg $xsa_path
} 
if {$emu_xsa_path ne "" && [file exists $emu_xsa_path]} {
  lappend plat_arg -hw_emu
  lappend plat_arg $emu_xsa_path
}

platform create -name $platform_name -desc " This TRD platform targets VEK280 board which is the first Versal AI Edge series evaluation kit, enabling designers to develop solutions using AI and DSP engines. More information at https://www.xilinx.com/products/boards-and-kits/vek280.html" {*}$plat_arg -out $platform_out -no-boot-bsp

domain create -name aiengine -os aie_runtime -proc {ai_engine}
domain config -qemu-data $boot_dir_path
domain create -name xrt -proc psv_cortexa72 -os linux -sd-dir $img_dir_path
domain config -boot $boot_dir_path
domain config -generate-bif 

domain config -qemu-data $boot_dir_path

platform generate
