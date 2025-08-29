#!/bin/sh
# Alpine Linux: install & enable cloud-init + qemu-guest-agent
# Usage:
#   post-install.sh
# Notes:
# - Proxmox: enable "QEMU Guest Agent" on the VM/template.
# - Cloud-Init datasource set to NoCloud/ConfigDrive for Proxmox.

set -eu

echo "Install QEMU Guest Agent and Cloud init"

# Mount
echo "- Mount base system"
# Mount root and boot
mount /dev/vda3 /mnt
mount /dev/vda1 /mnt/boot

# Bind-mount runtime filesystems
mount -t proc /proc /mnt/proc
mount --rbind /sys /mnt/sys
mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev
mount --make-rslave /mnt/dev

# Run as chroot in /mnt
run() {
	chroot "/mnt" /bin/sh -eux -c "$*"
}

# Update indexes and install packages
run 'apk update'
# qemu-guest-agent
# cloud-init: cloud init 
# cloud-utils-growpart + e2fsprogs-extra: resize partition
run 'apk add --no-cache sudo qemu-guest-agent cloud-init cloud-utils-growpart e2fsprogs-extra'

# Enable qemu-guest-agent service at boot (OpenRC)
run "rc-update add qemu-guest-agent default || true"
# Start guest agent immediately
run 'service qemu-guest-agent start || true'

# Cloud-Init datasource config for Proxmox
run 'mkdir -p /etc/cloud/cloud.cfg.d'
run 'printf "%s\n" "datasource_list: [ NoCloud, ConfigDrive ]" > /etc/cloud/cloud.cfg.d/90_pve.cfg'
# we do not enabled cloud init yet (will be done as last provision script)
# run 'setup-cloud-init'

# Unmount
echo "- Unmount base system"
umount -l /mnt/dev
umount -l /mnt/sys
umount -l /mnt/proc
umount -l /mnt/boot
umount -l /mnt

echo "Installed QEMU Guest Agent and Cloud init"
