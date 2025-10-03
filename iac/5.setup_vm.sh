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

# use env var / argument to specify IP and ssh key to use

# Execute the command
$SCRIPT_DIR/src/ansible.sh vm/setup "$@"
