# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set_property BITSTREAM.GENERAL.NPIDMAMODE Yes [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property CLOCK_DEDICATED_ROUTE ANY_CMT_REGION [get_nets vek280_camerafmc_i/cips_ss_0/clk_wizard_1/inst/clock_primitive_inst/clk_out1]
