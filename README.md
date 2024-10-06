# Overview

Tria Vitis 2023.2 platforms and overlays.

# Documentation

The following series of Hackster projects describe how this github repository was created and serves as documentation:

[Part 1](https://avnet.me/tria-vitis-2023.2-part1) : Tria Vitis Platforms - Building the Foundational Designs

[Part 2](https://avnet.me/tria-vitis-2023.2-part2) : Tria Vitis Platforms - Creating a Common Platform

[Part 3](https://avnet.me/tria-vitis-2023.2-part3) : Tria Vitis Platforms - Adding support for Vitis-AI

[Part 4](https://avnet.me/tria-vitis-2023.2-part4) : Tria Vitis Platforms - Adding support for Hailo-8

[Part 5](https://avnet.me/tria-vitis-2023.2-part5) : Tria Vitis Platforms - Adding support for ROS2

The motivation of this series of projects is to enable users to create their own custom AI applications.

# Build Instructions

## Preparation

Clone repository:
- git clone --recursive --branch 2023.2 https://github.com/AlbertaBeef/tria-vitis-platforms
- cd tria-vitis-platforms

Download DPU IP:
- cd common/overlays
- source ./get_dpu_ip.sh
- cd ../..

## ZUBoard Instructions

Navigate to zub1cg directory:
- cd zub1cg

Build (all) the zub1cg vitis platforms:
- make platform PFM=zub1cg_sbc_minimal
- make platform PFM=zub1cg_sbc_base
- make platform PFM=zub1cg_sbc_dualcam
- make platform PFM=zub1cg_sbc_dualcam1
- make platform PFM=zub1cg_sbc_dualcam2

Build (all) the  zub1cg vitis overlays:
- make overlay OVERLAY=benchmark
- make overlay OVERLAY=dualcam_dpu

Build the zub1cg petalinux project:
- make petalinux

Create the final zub1cg SD card image:
- ...

## Ultra96-V2 Instructions

Navigate to u96v2 directory:
- cd u96v2

Build (all) the u96v2 vitis platforms:
- make platform PFM=u96v2_sbc_minimal
- make platform PFM=u96v2_sbc_base
- make platform PFM=u96v2_sbc_dualcam
- make platform PFM=u96v2_sbc_dualcam1
- make platform PFM=u96v2_sbc_dualcam2

Build (all) the u96v2 vitis overlays:
- make overlay OVERLAY=benchmark
- make overlay OVERLAY=dualcam_dpu

Build the u96v2 petalinux project:
- make petalinux

Create the final u96v2 SD card image:
- ...

## UltraZed-7EV Instructions

Navigate to u96v2 directory:
- cd uz7ev

Build (all) the uz7ev vitis platforms:
- make platform PFM=uz7ev_sbc_base
- make platform PFM=uz7ev_sbc_nvme

Build (all) the uz7ev vitis overlays:
- make overlay OVERLAY=benchmark

Build the uz7ev petalinux project:
- make petalinux

Create the final uz7ev SD card image:
- ...





