#!/bin/sh

echo "==================== RAM INFO ===================="
awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {u=t-a; printf "Used: %.1fG / %.1fG (%.0f%%)\n", u/1024/1024, t/1024/1024, u/t*100}' /proc/meminfo
