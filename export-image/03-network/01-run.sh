#!/bin/bash -e

# Use systemd-resolved
ln -rsf "${ROOTFS_DIR}/run/systemd/resolve/stub-resolv.conf" "${ROOTFS_DIR}/etc/resolv.conf"
