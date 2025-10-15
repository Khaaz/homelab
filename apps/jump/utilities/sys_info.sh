#!/bin/sh

echo "==================== SYSTEM INFO ===================="
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime | sed 's/.*up *//; s/,.*//')"
echo "Date: $(date)"
echo

echo "-------------------- CPU --------------------"
t1=$(grep '^cpu ' /proc/stat); sleep 1; t2=$(grep '^cpu ' /proc/stat)
awk -v t1="$t1" -v t2="$t2" '
BEGIN {
  split(t1,a," "); split(t2,b," ");
  idle1=a[5]+a[6]; idle2=b[5]+b[6];
  total1=0; total2=0;
  for(i=2;i<=length(a);i++) total1+=a[i];
  for(i=2;i<=length(b);i++) total2+=b[i];
  usage=(1-(idle2-idle1)/(total2-total1))*100;
  printf "CPU usage: %.1f%%\n", usage;
}'

echo
echo "-------------------- MEMORY --------------------"
awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}END{u=t-a; printf "Used: %.1fG / %.1fG (%.0f%%)\n", u/1024/1024, t/1024/1024, u/t*100}' /proc/meminfo

echo
echo "-------------------- DISK --------------------"
df -h | grep -E '^/dev' | awk '{printf "%-20s %-10s %-10s %-10s %s\n", $1, $2, $3, $5, $6}'

echo
echo "-------------------- NETWORK --------------------"
ip -4 addr show | awk '/inet /{print $2 " -> " $NF}'

echo "======================================================"
