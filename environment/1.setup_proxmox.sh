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
	echo "--dev mode will target the VM. Otherwise will target the 'real' server"
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
		*)
			echo "Unknown argument: $1"
			;;
	esac
	shift
done

#
## Core
#
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--limit vm"
else
	DEV_ARGS="--limit homelab"
fi

# Execute the command
$ROOT_DIR/iac/1.setup_proxmox.sh $DEV_ARGS "$@"
