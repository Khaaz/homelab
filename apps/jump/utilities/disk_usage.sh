#!/bin/sh

echo "==================== DISK INFO ===================="
df -h 2>/dev/null | grep -E '^/dev' | awk '{
  printf "%-20s %-10s %-10s %-10s %s\n", $1, $2, $3, $5, $6
}'
