#!/bin/bash -e

# add static ip to /etc/hosts
sed -i 's/127.0.1.1/192.168.1.1/' "${ROOTFS_DIR}/etc/hosts"
sed -i "s/${TARGET_HOSTNAME}/${TARGET_HOSTNAME}.moc.lan ${TARGET_HOSTNAME}/" "${ROOTFS_DIR}/etc/hosts"

# Install config files
install -m 644 files/interfaces.d/* "${ROOTFS_DIR}/etc/network/interfaces.d/"
install -m 644 files/rules.d/* "${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/sysctl.d/* "${ROOTFS_DIR}/etc/sysctl.d/"
install -m 644 files/systemd/network/* "${ROOTFS_DIR}/etc/systemd/network/"
install -m 644 files/systemd/resolved.conf "${ROOTFS_DIR}/etc/systemd/"
install -m 755 files/nftables.conf "${ROOTFS_DIR}/etc/"
install -m 644 files/iperf3.service "${ROOTFS_DIR}/etc/systemd/system/"
cat files/sshd_config.append >> "${ROOTFS_DIR}/etc/ssh/sshd_config"

# Enable/Disable services
on_chroot << EOF
systemctl disable avahi-daemon.service
systemctl disable dhcpcd.service
systemctl disable wpa_supplicant.service
systemctl enable systemd-resolved.service
systemctl enable systemd-networkd.service
systemctl enable nftables.service
systemctl enable iperf3.service
EOF
