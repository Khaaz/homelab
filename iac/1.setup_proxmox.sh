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
# Execute the command
PLAYBOOK=proxmox-setup
if [ -n "$1" ]; then
	PLAYBOOK=$1
	shift
fi
$SCRIPT_DIR/src/ansible.sh $PLAYBOOK "$@"
