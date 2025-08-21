#!/bin/sh

# Extract the distribution name from /etc/os-release
get_os() {
	if [ -f /etc/os-release ]; then
		. /etc/os-release
		echo "$ID"
	else
		echo "unknown"
	fi
}
