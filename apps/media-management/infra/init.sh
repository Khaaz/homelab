#!/bin/sh

# enable tun module: /dev/net/tun for Gluetun VPN
modprobe tun
echo "tun" >> /etc/modules

# Create dl directories
mkdir -p /mnt/media/media/anime
mkdir -p /mnt/media/media/movies
mkdir -p /mnt/media/media/series
mkdir -p /mnt/media/media/unsorted

mkdir -p /mnt/media/torrents/anime
mkdir -p /mnt/media/torrents/complete
mkdir -p /mnt/media/torrents/incomplete
mkdir -p /mnt/media/torrents/movies
mkdir -p /mnt/media/torrents/series
mkdir -p /mnt/media/torrents/unsorted

mkdir -p /mnt/media/usenet/anime
mkdir -p /mnt/media/usenet/complete
mkdir -p /mnt/media/usenet/incomplete
mkdir -p /mnt/media/usenet/movies
mkdir -p /mnt/media/usenet/series
mkdir -p /mnt/media/usenet/unsorted

mkdir -p /mnt/media/filebot
mkdir -p /mnt/media/watch

# Change permissionsw
chown -R nobody:nogroup /mnt/media
chmod -R 777 /mnt/media
