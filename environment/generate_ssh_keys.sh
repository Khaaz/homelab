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
	echo "Usage: $0 [--auto]"
	echo "--auto mode will automatically create all ssh config for each app-stack/proxmox-vm"
	exit 1
}

## Input verification
AUTO=false
while [ $# -gt 0 ]; do
	case "$1" in
		--auto)
			AUTO=true
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

ROOT_DIR="$SCRIPT_DIR/.."

#
## Core
#
# Execute the command
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/src/environment/generate_ssh_keys.sh proxmox --root "$@"
	$ROOT_DIR/src/environment/generate_ssh_keys.sh vm --root "$@"

	# Generate keys for each app stack
	for dir in "$ROOT_DIR"/apps/*/; do
		if [ -d "$dir" ]; then
			folder_name=$(basename "$dir")
			$ROOT_DIR/src/environment/generate_ssh_keys.sh "$folder_name" "$@"
		fi
	done
else
	# Pass through all parameters
	$ROOT_DIR/src/environment/generate_ssh_keys.sh "$@"
fi
