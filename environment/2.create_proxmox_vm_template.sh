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
	echo "Usage: $0 [--auto] [--dev]"
	echo "--auto mode will use sensible defaults (no-op in this script)"
	echo "--dev mode will use dev/vm settings"
	exit 1
}

## Input verification
DEV=false
AUTO=false
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			;;
		--auto)
			AUTO=true
			;;
		--help)
			usage
			;;
	esac
	shift
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

# --auto is intentionally a no-op in this script to keep behavior unchanged

# Execute the command
$ROOT_DIR/iac/2.create_proxmox_vm_template.sh "$DEV_ARGS" "$@"
