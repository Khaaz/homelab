#!/bin/sh

# enable tun module: /dev/net/tun for Gluetun VPN
modprobe tun
echo "tun" >> /etc/modules

# Create dl directories
mkdir -p /mnt/data/media/anime
mkdir -p /mnt/data/media/movies
mkdir -p /mnt/data/media/series
mkdir -p /mnt/data/media/unsorted

mkdir -p /mnt/data/torrents/anime
mkdir -p /mnt/data/torrents/complete
mkdir -p /mnt/data/torrents/incomplete
mkdir -p /mnt/data/torrents/movies
mkdir -p /mnt/data/torrents/series
mkdir -p /mnt/data/torrents/unsorted

mkdir -p /mnt/data/usenet/anime
mkdir -p /mnt/data/usenet/complete
mkdir -p /mnt/data/usenet/incomplete
mkdir -p /mnt/data/usenet/movies
mkdir -p /mnt/data/usenet/series
mkdir -p /mnt/data/usenet/unsorted

mkdir -p /mnt/data/filebot
mkdir -p /mnt/data/watch

# Change permissions
chown -R nobody:nogroup /mnt/data
chmod -R 2777 /mnt/data
