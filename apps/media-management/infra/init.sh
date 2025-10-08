#!/bin/sh

# enable tun module: /dev/net/tun for Gluetun VPN
modprobe tun
echo "tun" >> /etc/modules
