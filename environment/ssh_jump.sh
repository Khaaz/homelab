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
ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
    -o StrictHostKeyChecking=no \
	-p 2222 \
    admin@192.168.1.200
