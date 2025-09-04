# Example answer file for setup-alpine
# See: https://wiki.alpinelinux.org/wiki/Using_an_answerfile_with_setup-alpine

# Keyboard & hostname
KEYMAPOPTS="us us" # we need to keep it us us because of Packer install (and boot command)
HOSTNAMEOPTS="template-alpine"

# Network: DHCP on eth0 (change to ens18 if needed)
DEVDOPTS="mdev"

INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
"
DNSOPTS="-n 8.8.8.8"
PROXYOPTS=none

# Timezone
TIMEZONEOPTS="-z UTC"
# NTP (optional)
NTPOPTS=none

# Repo
APKREPOSOPTS="-c -1" # pick first mirror (CDN)

# User
// USEROPTS="none"
# -a create an admin user (added to wheel + doas)
USEROPTS="-a admin"

# SSH server (OpenSSH).
SSHDOPTS="-c openssh"
ROOTSSHKEY="http://${control_node_ip}:8098/root-key"

# Disk: install to virtio disk, 'sys' mode (regular install)
DISKOPTS="-m sys /dev/sda"
// DISKOPTS=none

# config storage
LBUOPTS=none

# repo cache
APKCACHEOPTS=none
