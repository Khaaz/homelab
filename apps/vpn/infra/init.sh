# enable tun module: /dev/net/tun for tailscale
modprobe tun
echo "tun" >> /etc/modules
