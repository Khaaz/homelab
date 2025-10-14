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
	echo "Usage: $0 [--auto] <vm>"
	echo "--auto mode will use sensible defaults"
	exit 1
}

## Input verification
AUTO=false
VM_NAME=""
while [ $# -gt 0 ]; do
	case "$1" in
		--auto)
			AUTO=true
			shift
			;;
		--help)
			usage
			;;
		*)
			VM_NAME="$1"
			shift
			;;
	esac
done

if [ -z  "$VM_NAME" ]; then
	usage
fi

if [ "$AUTO" = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

#
## Core
#
AUTO_ARGS=""
if [ "$AUTO" = true ]; then
	AUTO_ARGS="--auto"
fi

if [ "$VM_NAME" = "jump" ]; then
	$SCRIPT_DIR/4-1.setup_vm_jump.sh $AUTO_ARGS
else
	# Execute command directely via jump / resolve vm name via dns
	ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
		-o StrictHostKeyChecking=no \
		-p 2222 \
		admin@192.168.1.200 \
		"./homelab/apps/jump/ansible_vm.sh $VM_NAME"
fi
