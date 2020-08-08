#!/bin/bash -e

# add static ip to /etc/hosts
sed -i 's/127.0.1.1/192.168.69.1/' "${ROOTFS_DIR}/etc/hosts"
sed -i "s/${TARGET_HOSTNAME}/${TARGET_HOSTNAME}.moc.lan ${TARGET_HOSTNAME}/" "${ROOTFS_DIR}/etc/hosts"

# Install config files
install -m 644 -t "${ROOTFS_DIR}/etc/dnsmasq.d/" files/dnsmasq.d/*
install -m 644 -t "${ROOTFS_DIR}/etc/network/interfaces.d/" files/interfaces.d/*
install -m 644 -t "${ROOTFS_DIR}/etc/sysctl.d/" files/sysctl.d/*
cat files/dhcpcd.conf.append >> "${ROOTFS_DIR}/etc/dhcpcd.conf"
install -m 755 files/nftables.conf "${ROOTFS_DIR}/etc/"
install -m 644 files/radvd.conf "${ROOTFS_DIR}/etc/"
install -m 644 files/iperf3.service "${ROOTFS_DIR}/etc/systemd/system/"
cat files/sshd_config.append >> "${ROOTFS_DIR}/etc/ssh/sshd_config"

# Enable services
on_chroot << EOF
systemctl enable dnsmasq.service
systemctl enable nftables.service
systemctl enable radvd.service
systemctl enable iperf3.service
EOF
