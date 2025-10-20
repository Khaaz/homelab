#!/bin/sh

echo "==================== CPU INFO ===================="
awk -v RS="" '{split($0,a,"\n"); for(i in a){if(a[i]~/^cpu /){split(a[i],b," "); idle=b[5]+b[6]; total=0; for(j=2;j<=NF;j++) total+=b[j]; printf "CPU usage: %.1f%%\n", (1 - idle/total)*100}}}' /proc/stat
