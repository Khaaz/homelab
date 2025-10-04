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

#
## Core
#
# Execute command directely via jump / resolve vm name via dns
ssh -t -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
    -o StrictHostKeyChecking=no \
	-p 2222 \
    admin@192.168.1.200 \
	"./homelab/apps/jump/ssh_vm.sh $1"
