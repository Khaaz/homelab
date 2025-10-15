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
	echo "Usage: $0 [--auto] [--dev] [--destroy]"
	echo "--auto mode will use sensible defaults (no-op in this script)"
	echo "--dev mode will use dev/vm settings"
	echo "--destroy will bring down all VMs"
	exit 1
}

## Input verification
DEV=false
DESTROY=false
AUTO=false
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
		--auto)
			AUTO=true
			shift
			;;
		--help)
			usage
			;;
	esac
done

if [ "$AUTO" = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

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

# --auto is intentionally a no-op in this script to keep behavior unchanged

# Execute the command
$ROOT_DIR/iac/3.manage_proxmox_vms.sh "$DEV_ARGS" "$DESTROY_ARGS" "$@"
