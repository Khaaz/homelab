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
SSH_KEY=$ROOT_DIR/config/ssh/$1/automation_key

$ROOT_DIR/iac/5.setup_vm.sh setup --app "$1" --ip "$TARGET_IP" --key "$SSH_KEY" --refresh-config full
