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
	echo "Usage: $0 [--auto] [--reset]"
	echo "--auto mode will automatically create all ssh config for each app-stack/proxmox-vm"
	echo "--reset mode will force recreating the ssh keys"
	exit 1
}

## Input verification
AUTO=false
RESET=false
while [ $# -gt 0 ]; do
	case "$1" in
		--auto)
			AUTO=true
			shift
			;;
		--reset)
			RESET=true
			shift
			;;
		--help)
			usage
			;;
	esac
done

if [ $AUTO = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

#
## Core
#
RESET_ARGS=""
if [ "$RESET" = true ]; then
	RESET_ARGS="--reset"
fi

# Execute the command
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/src/environment/generate_ssh_keys.sh proxmox --root "$@"
	$ROOT_DIR/src/environment/generate_ssh_keys.sh vm --root $RESET_ARGS "$@"

	# Generate keys for each app stack
	for dir in "$ROOT_DIR"/apps/*/; do
		if [ -d "$dir" ]; then
			folder_name=$(basename "$dir")
			$ROOT_DIR/src/environment/generate_ssh_keys.sh "$folder_name" $RESET_ARGS "$@"
		fi
	done
else
	# Pass through all parameters
	$ROOT_DIR/src/environment/generate_ssh_keys.sh $RESET_ARGS "$@"
fi
