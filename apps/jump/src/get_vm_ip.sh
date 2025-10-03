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
source_ips() {
	SOURCED_SCRIPT_DIR="$SCRIPT_DIR"
	. "$SCRIPT_DIR/src/source_vms_ip.sh"
}

source_ips

VM_ENV_VAR_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_')_IP

# Evaluate the value of the VM_ENV_VAR_NAME which will output the actual ip
# echo the result so the caller script can use it
echo $(eval echo \$$VM_ENV_VAR_NAME)
