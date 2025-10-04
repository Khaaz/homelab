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
if [ -z  "$1" ]; then
	usage
fi

#
## Core
#

# Source the source_vms_ip.sh script
# This runs the script in the current shell context so exports are preserved
# Export "SOURCED_SCRIPT_DIR" in to preserve path
source_ips() {
	SOURCED_SCRIPT_DIR="$SCRIPT_DIR"
	. "$SCRIPT_DIR/source_vms_ip.sh"
}

source_ips

VM_ENV_VAR_NAME=$(echo "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_')_IP

echo "================" >&2
echo "VM_ENV_VAR_NAME: $VM_ENV_VAR_NAME" >&2
echo "Target IP: $(eval echo \$$VM_ENV_VAR_NAME)" >&2
echo "================" >&2

# Evaluate the value of the VM_ENV_VAR_NAME which will output the actual ip
# echo the result so the caller script can use it
echo $(eval echo \$$VM_ENV_VAR_NAME)
