#!/bin/sh

# Install Intel media drivers for transcoding
apk add linux-firmware-intel intel-media-driver libva-utils

# Add users to video group for transcoding
gpasswd --add admin video
gpasswd --add app video

# Create dl directories
mkdir -p /mnt/data/media/anime
mkdir -p /mnt/data/media/movies
mkdir -p /mnt/data/media/series
mkdir -p /mnt/data/media/unsorted

mkdir -p /mnt/data/transcode

chown -R nobody:nogroup /mnt/data
chmod -R 2777 /mnt/data

# Create apps data
mkdir -p /mnt/apps-data/yamtrack
chown -R nobody:nogroup /mnt/apps-data
chmod -R 2777 /mnt/apps-data
