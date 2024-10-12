#!/bin/bash
#
# 1 Overview
#    1.1
#        For the xilinx ZCU102/104 DPU platform, we use the SD Card ext File
#        System as the default. Please refer to the details.
#        Xilinx's document UG1144 "Configuring SD Card ext File System Boot"
#
#    1.2
#        Using the Vitis tool to compile the DPU's platform will produce an
#        zcu102/104_dpu output directory, like this:
#
#        zcu102_dpu
#        ......
#        ----| pre-built
#        ----| ----| BOOT.BIN
#        ----| xrt |
#        ----| ----| image |
#        ----| ----| ----- | image.ub
#        ----| ----| ----- | init.sh
#        ----| ----| ----- | platform_desc.txt
#        ----| ----| ----- | rootfs.tar.gz
#        ......
#
#        Or 
#
#        compiling a kernel based on the DPU platform will generate an 
#        sd_card output directory, such as this:
#
#        sd_card
#        ----| BOOT.BIN
#        ----| image.ub
#        ----| rootfs.tar.gz
#        ----| dpu.xclbin
#        ----| init.sh
#        ----| zcu102_dpu.hwh
#
#        Where roots.tar.gz needs to be copied to the ext4 partition, other 
#        files need to be copied to the fat32 partition, which is inconvenient
#        for user operations. This script is written to solve this problem.
#
#
# 2 What will the script do
#    2.1
#        This script based on the loop device create two partitions automatically.
#        The first partition is FAT32, the size is 400MB, the second partition
#        is EXT4, and the size is the actual size after decompressing rootfs.tar.gz.
#    2.2
#        Automatic copy the corresponding file to the corresponding partition
#    2.3
#        Produce an image file with a .img suffix. This image can be used to 
#        flash SD cards on any machine. For example, using the "etcher" tool,
#        you can directly FLash this .img to SD on MAC, Windows, and Linux machines.
#    2.4
#        If the user inserts the SD card, it can also help the user to flash
#        the image to the SD card by specifying the device name of the SD
#        card device. Note: This step must be specified correct, otherwise
#        it may broken the data of other disks.
#
#
# 3 How to use scripts
#        If there is no sd_card directory, create one and copy the files you
#        need to use in the sd_card directory, then put the script into the
#        directory and execute.
#
# 4 Output
#        ➜sudo ./flash_sd_card.sh
#        Setting up partition      [✔]
#        Copying contents to fat32 [✔]
#        Copying contents to ext4  [✔]
#        avnet-{platform}-v2022.2-{date}.img successful generated[✔]
#
#        Do you want to flash SD card(y/n): y
#        /dev/sdc2        15G  1.2G   13G   9% /media/wind/ROOTFS
#        Please input your SD card dev(/dev/sdX): /dev/sdc
#        1.73GiB 0:05:19 [5.55MiB/s] [=========================>] 100%
#
#        Congratulations, done!
#
# 5 Requirements
#        *pv
#        *dd
#        *mkfs
#
#        have sudo permission or root user
#
# If you have any questions, please contact yey@xilinx.com
#

set -e

############################  SETUP PARAMETERS
version=1.0

ROOTFS="rootfs"
BOOT_DIM=400
#BOOT_DIM=4096

# add 4.0GB for Vitis-AI content
#VAI_DIM=4096
# add 7.5GB for Vitis-AI content
VAI_DIM=7680
# add 9.5GB for Vitis-AI content
#VAI_DIM=9728

FREELO="$( losetup -f)"

RF_LIST=(\
    BOOT/boot.bin \
    BOOT/boot.scr \
    BOOT/image.ub \
    BOOT/platform_desc.txt \
)

############################  BASIC SETUP TOOLS
msg() {
    printf '%b' "$1" >&2
}

report() {
    if [ "$ret" -eq '0' ]; then
        printf "\33[32m[✔]\33[0m\n"
    else
        printf "\33[31m[✘]\33[0m\n"
    fi
}

privs ()
{
    if [ "$(id -u)" != 0 ]; then
        echo "Sorry, $(basename "$0") must be run as root."
        exit 1
    fi
}


file_must_exists() {
    if [ ! -e "$1" ]; then
        echo "You must have '$1' file to continue."
        clean_work_area
        exit 1
    fi
}

############################ SETUP FUNCTIONS

lodetach () {
    device="${1}"
    attempt="${2:-1}"

    if [ "${attempt}" -gt 3 ]
    then
        echo "Failed to detach loop device '${device}'."
        exit 1
    fi

    if [ -x "$(which udevadm 2>/dev/null)" ]
    then
        udevadm settle
    fi

    sync
    sleep 1

     losetup -d "${device}" || lodetach "${device}" "$(expr ${attempt} + 1)"
}

calc_space () {
    local tar_file="$1"

    mkdir ${ROOTFS} && tar -zxf "$tar_file" -C ${ROOTFS}

    rootfs_dim="$( du -ms ${ROOTFS} | cut -f1)"

    #echo "rootfs size = ${rootfs_dim} MB"
    rootfs_dim=$((rootfs_dim+VAI_DIM))
    #echo "rootfs size = ${rootfs_dim} MB"

    img_dim="$(echo $(expr "${rootfs_dim}" + "${rootfs_dim}" \* 10 / 100 + 1))"
    img_dim="$((img_dim + BOOT_DIM + 100))"

    dd if=/dev/zero of=$IMG bs=1024k count=0 seek=${img_dim} >/dev/null 2>&1
}

mkpart_mkfs () {
    msg "Setting up partition      "

    losetup "$FREELO" "$IMG" 0
    parted -s "${FREELO}" mklabel msdos || true
    parted -a optimal -s "${FREELO}" mkpart primary fat32 1 "${BOOT_DIM}" || true
    parted -a optimal -s "${FREELO}" mkpart primary ext4 "${BOOT_DIM}" 100% || true
    parted -s "${FREELO}" set 1 boot on || true
    parted -s "${FREELO}" set 1 lba off || true

    mkfs.vfat -F 32 -n "BOOT" "${FREELO}"p1 >/dev/null 2>&1
    mkfs.ext4 -L "ROOTFS" "${FREELO}"p2 >/dev/null 2>&1

    ret="$?"
    report
}

boot_cp () {
    msg "Copying contents to fat32 "

    mkdir -p binary.tmp
    mount "${FREELO}"p1 binary.tmp

    for ((item=0;item<${#RF_LIST[@]};item++))
    do
        [ -e "${RF_LIST[item]}" ] && cp -f "${RF_LIST[item]}" binary.tmp
    done

    sync
    sleep 1
    umount binary.tmp

    ret="$?"
    report
    }

rootfs_cp () {
    msg "Copying contents to ext4  "
    mount "${FREELO}"p2 binary.tmp
    tar -xzf "$1" -C binary.tmp
    sync
    ret="$?"
    report

    
    msg "Vitis-AI - Copying AI models "
    platform=$(cat BOOT/platform_desc.txt)
    msg "for $platform " 
    if [ "$platform" = "zub1cg_sbc" ]; then
      msg "(b512-lr & b128-lr) "
      mkdir -p binary.tmp/usr/share/vitis_ai_library
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b512-lr.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1
      ln -sf models.b512-lr binary.tmp/usr/share/vitis_ai_library/models
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b128-lr.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1
    elif [ "$platform" = "u96v2_sbc" ]; then
      msg "(b2304-lr & b1152-hr) "
      mkdir -p binary.tmp/usr/share/vitis_ai_library
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b2304-lr.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1
      ln -sf models.b2304-lr binary.tmp/usr/share/vitis_ai_library/models
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b1152-hr.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1
    elif [ "$platform" = "uz7ev_evcc" ]; then
      msg "(b4096-lr) "
      mkdir -p binary.tmp/usr/share/vitis_ai_library
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b4096-lr.1of2.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1
      tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-models.b4096-lr.2of2.tar.gz -C binary.tmp/usr/share/vitis_ai_library/. 2>&1      
      ln -sf models.b4096-lr binary.tmp/usr/share/vitis_ai_library/models      
    else
      msg "(unknown) "
    fi
    sync
    ret="$?"
    report
    

    msg "Vitis-AI - Set default app "
    if [ "$platform" = "zub1cg_sbc" ]; then
      msg "to tria-zub1cg-benchmark "
      echo tria-zub1cg-benchmark > binary.tmp/etc/dfx-mgrd/default_firmware 2>&1
    elif [ "$platform" = "u96v2_sbc" ]; then
      msg "to tria-u96v2-benchmark "
      echo tria-u96v2-benchmark > binary.tmp/etc/dfx-mgrd/default_firmware 2>&1
    elif [ "$platform" = "uz7ev_evcc" ]; then
      msg "to tria-uz7ev-benchmark "
      echo tria-uz7ev-benchmark > binary.tmp/etc/dfx-mgrd/default_firmware 2>&1
    fi
    sync
    ret="$?"
    report
    
    msg "Vitis-AI - Copying examples apps "
    tar -xvzf ../../common/sdcard/content/vitis-ai-3.0-examples.tar.gz -C binary.tmp/home/root/. 2>&1
    sync
    ret="$?"
    report

    msg "Finalizing ext4           "
    sync
    sync
    sleep 1
    umount binary.tmp
    rmdir binary.tmp

    lodetach ${FREELO}

    ret="$?"
    report

    msg "$IMG successful generated"
    ret="$?"
    report
    echo ''
}

clean_work_area () {

    if mount | grep "binary.tmp" >/dev/null 2>&1;
    then
        umount ./binary.tmp >/dev/null 2>&1
    fi

    [ -d "binary.tmp" ] && rm -rf binary.tmp
    [ -d ${ROOTFS} ] && rm -rf ${ROOTFS}
}

finalize () {

    printf "\nCongratulations, done!"

    clean_work_area
}

############################ MAIN()

main () {

    trap "echo; echo -n Removing work area...; clean_work_area; echo exit;exit" INT

    if [ -e BOOT/platform_desc.txt ];then
        IMG="tria-$(cat BOOT/platform_desc.txt)-v2023.2-$(date +%F).img"
    else
        IMG="tria-v2023.2-$(date +%F).img"
    fi

    privs

    file_must_exists "BOOT/BOOT.BIN"
    file_must_exists "BOOT/boot.scr"
    file_must_exists "BOOT/image.ub"
    file_must_exists "ROOTFS/rootfs.tar.gz"

    calc_space       "ROOTFS/rootfs.tar.gz"
    mkpart_mkfs

    boot_cp
    rootfs_cp        "ROOTFS/rootfs.tar.gz"

    finalize
}

main "$@"
