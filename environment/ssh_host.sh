#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

#
## Core
#
ssh -i $SCRIPT_DIR/../config/ssh/proxmox/automation_key.dev \
    -o StrictHostKeyChecking=no \
    automation@192.168.1.200
