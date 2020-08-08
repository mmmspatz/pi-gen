#!/bin/bash -e

install -D -m 755 files/rpi-alias "${ROOTFS_DIR}/etc/initramfs/post-update.d/rpi-alias"

on_chroot << EOF
dpkg-reconfigure -f noninteractive raspberrypi-kernel
EOF
