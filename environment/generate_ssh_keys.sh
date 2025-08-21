#!/bin/bash

# Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

AUTO=false
if [ "$1" = "--auto" ]; then
	AUTO=true
	echo "LOG: Executing in AUTO mode (infra ready)"
fi

ROOT_DIR="$SCRIPT_DIR/.."

# Execute the command
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/src/environment/generate_ssh_keys.sh ansible 
else
	# Pass through all parameters
	$ROOT_DIR/src/environment/generate_ssh_keys.sh "$@"
fi
