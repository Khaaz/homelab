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
	echo "Usage: $0 [--pull-mode <safe|reset>]"
	echo
	echo "Options:"
	echo "  --pull-mode, -pm  Set pull mode (default: safe)"
	echo "    - safe:  copy only when the file does not exist locally"
	echo "    - reset: always overwrite local files (keep a .old file)"
	echo
	echo "Examples:"
	echo "  $0 --pull-mode safe"
	echo "  $0 -pm reset"

	exit 1
}

## Input verification
PULL_MODE="safe"
PLAYBOOK="pull-config"
while [ $# -gt 0 ]; do
	case "$1" in
		--pull-mode|-pm)
			PULL_MODE=$2
			shift 2
			;;
		--help)
			usage
			;;
		*)
			usage
			;;
	esac
done

#
## Core
#
# Execute the command
$SCRIPT_DIR/src/ansible.sh "jump/$PLAYBOOK" -e "pull_config_mode=$PULL_MODE" "$@"
