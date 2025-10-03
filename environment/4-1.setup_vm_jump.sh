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
	echo "Usage: $0 [--auto]"
	echo "--auto mode will use sensible defaults to configure jump VM"
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

if [ "$AUTO" = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

#
## Core
#
# Execute the command
if [ "$AUTO" = true ]; then
	# Execute with appropriate arguments
	$ROOT_DIR/iac/4.setup_vm_jump.sh setup --refresh-config full --refresh-ssh new
else
	# Pass through all parameters
	$ROOT_DIR/iac/4.setup_vm_jump.sh "$@"
fi
