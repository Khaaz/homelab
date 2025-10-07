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

LOCATE="cd /home/admin/homelab/apps/jump 2> /dev/null"

ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
    -o StrictHostKeyChecking=no \
	-p 2222 \
	-t \
    admin@192.168.1.200 \
	"$LOCATE; exec "'$SHELL'
