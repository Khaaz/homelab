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
	echo "Usage: $0 <playbook>"
	exit 1
}

## Input verification
if [ -z "$1" ]; then
	usage
fi
PLAYBOOK="$1"
shift

#
## Core
#
# Execute the command
$SCRIPT_DIR/src/ansible.sh "$PLAYBOOK" "$@"
