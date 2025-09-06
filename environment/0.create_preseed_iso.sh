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
	echo "Usage: $0 [--auto] [--dev]"
	echo "--auto mode will automatically configure preseed config from env var"
	echo "--dev mode will use dev ssh keys (appropriate for VM setup)"
	exit 1
}

## Input verification
AUTO=false
DEV=false
while [ $# -gt 0 ]; do
	case "$1" in
		--auto)
			AUTO=true
			;;
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

if [ $AUTO = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

ROOT_DIR="$SCRIPT_DIR/.."

#
## Core
#
# Execute the command
# Build arguments dynamically
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--dev"
fi

# Execute with appropriate arguments
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/preseed/create_preseed_iso.sh --preseed-cfg $DEV_ARGS
else
	# Pass through all parameters plus any additional flags
	$ROOT_DIR/preseed/create_preseed_iso.sh $DEV_ARGS "$@"
fi
