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
$SCRIPT_DIR/generate-ssh-keys/main.sh "$@"
