#!/bin/bash

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
	echo "--auto mode will automatically configure all .env from config/global-config.toml"
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
## Execute the command
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/src/environment/generate_env.sh
else
	# Pass through all parameters
	$ROOT_DIR/src/environment/generate_env.sh "$@"
fi
