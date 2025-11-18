#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

#
## Usage
#
usage() {
	echo "Usage: $0 [--auto]"
	echo "--auto mode will use sensible defaults"
	exit 1
}

#
## Input verification
#
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
		*)
			shift
			;;
	esac
done

if [ "$AUTO" = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

#
## Core
#
echo "LOG: Setting up jump VM"
AUTO_ARGS=""
if [ "$AUTO" = true ]; then
	AUTO_ARGS="--auto"
fi
$SCRIPT_DIR/4-1.setup_vm_jump.sh $AUTO_ARGS

echo "LOG: Setting up all other VMs"
$SCRIPT_DIR/4-3.setup_vms.sh $AUTO_ARGS
