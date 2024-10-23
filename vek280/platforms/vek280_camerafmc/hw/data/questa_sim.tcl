# (C) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set_property -name questa.compile.sccom.more_options -value {-suppress sccom-6168} -objects [current_fileset -simset]

