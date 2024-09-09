# Overview

Tria Vitis platforms and overlays 

# ZUBoard Instructions

cd zub1cg

Build zub1cg vitis platforms:
- make platform PFM=zub1cg-base-minimal
- make platform PFM=zub1cg-base-base
- make platform PFM=zub1cg-base-dualcam
- make platform PFM=zub1cg-base-dualcam1
- make platform PFM=zub1cg-base-dualcam2

Build zub1cg vitis overlays:
- make overlay OVERLAY=benchmark
- make overlay OVERLAY=dualcam_dpu

Build zub1cg petalinux project:
- make petalinux

Create final SD card image:
- ...

# Ultra96-V2 Instructions

cd u96v2

Build u96v2 vitis platforms:
- make platform PFM=u96v2-base-minimal
- make platform PFM=u96v2-base-base
- make platform PFM=u96v2-base-dualcam
- make platform PFM=u96v2-base-dualcam1
- make platform PFM=u96v2-base-dualcam2

Build u96v2 vitis overlays:
- make overlay OVERLAY=benchmark
- make overlay OVERLAY=dualcam_dpu

Build u96v2 petalinux project:
- make petalinux

Create final SD card image:
- ...

# UltraZed-7EV Instructions

...

# VEK280 Instructions

...

# VE2302-AI-Kit Instructions

...




