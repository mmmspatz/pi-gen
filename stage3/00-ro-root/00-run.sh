#!/bin/bash -e

install -m 755 files/btrfs-tmpfs "${ROOTFS_DIR}/etc/initramfs-tools/scripts/local-bottom/"
mkdir "${ROOTFS_DIR}/ramdisk/"

on_chroot << EOF
dpkg-reconfigure -f noninteractive raspberrypi-kernel
EOF
