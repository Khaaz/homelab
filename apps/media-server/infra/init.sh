#!/bin/sh

# Create dl directories
mkdir -p /mnt/data/media/anime
mkdir -p /mnt/data/media/movies
mkdir -p /mnt/data/media/series
mkdir -p /mnt/data/media/unsorted

mkdir -p /mnt/data/transcode

# Change permissions
chown -R nobody:nogroup /mnt/data
chmod -R 2777 /mnt/data
