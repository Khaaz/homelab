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
	echo "Usage: $0 [--dev] [--destroy]"
	echo "--dev mode will use dev/vm settings"
	echo "--destroy will bring down all VMs"
	exit 1
}

## Input verification
DEV=false
DESTROY=false
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			shift
			;;
		--destroy)
			DESTROY=true
			shift
			;;
		--help)
			usage
			;;
	esac
done

#
## Core
#
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--dev"
fi
DESTROY_ARGS=""
if [ "$DESTROY" = true ]; then
	DESTROY_ARGS="--destroy"
fi

# Execute the command
$ROOT_DIR/iac/3.manage_proxmox_vms.sh "$DEV_ARGS" "$DESTROY_ARGS" "$@"
