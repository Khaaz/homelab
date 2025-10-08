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
echo "Setting up jump VM"
$SCRIPT_DIR/4-1.setup_vm_jump.sh --auto

echo "Setting up all other VMs"
$SCRIPT_DIR/4-3.setup_vms.sh
