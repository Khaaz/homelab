#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
usage() {
	echo "Usage: $0 <vm>"
	exit 1
}

## Input verification
if [ -z  "$1"]; then
	usage
fi

$SCRIPT_DIR/4-1.setup_vm_jump.sh --auto

$SCRIPT_DIR/4-3.setup_vms.sh

# setup_jump
# setup_vms

#
## Core
#
# Execute command directely via jump / resolve vm name via dns
# imagine something like:
# ssh -t -i $SCRIPT_DIR/../config/ssh/proxmox/admin_key \
#     -o StrictHostKeyChecking=no \
#     homelab@192.168.1.200 \
# 	  "execute_ansible $1"
