#!/bin/sh

## Prerequesites
get_script_dir() {
	 # Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ROOT_DIR="$SCRIPT_DIR/.."

## Usage
usage() {
	echo "Usage: $0 [--dev]"
	echo "--dev mode will use dev/vm settings"
	exit 1
}

## Input verification
DEV=false
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			;;
		--help)
			usage
			;;
	esac
	shift
done

#
## Core
#
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--dev"
fi

# Execute the command
$ROOT_DIR/iac/2.create_proxmox_vm_template.sh "$DEV_ARGS" "$@"
