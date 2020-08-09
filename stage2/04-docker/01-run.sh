#!/bin/bash -e

gpg --dearmor -o ${ROOTFS_DIR}/usr/share/keyrings/docker-archive-keyring.gpg < files/docker-archive-keyring.gpg.key

ARCH=$(on_chroot << EOF
dpkg --print-architecture
EOF
)

on_chroot << EOF
echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] http://download.docker.com/linux/debian ${RELEASE} stable" > /etc/apt/sources.list.d/docker.list
EOF

on_chroot << EOF
apt-get update
EOF
