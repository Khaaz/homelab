#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)
ROOT_DIR="$SCRIPT_DIR/../.."

## Usage
usage() {
	echo "Usage: $0 <vm>"
	exit 1
}

## Input verification
if [ -z  "$1" ]; then
	usage
fi

#
## Core
#

TARGET_IP=$("$SCRIPT_DIR/src/get_vm_ip.sh" "$1")

ssh -i $ROOT_DIR/config/ssh/$1/admin_key \
    -o StrictHostKeyChecking=no \
    admin@$TARGET_IP
