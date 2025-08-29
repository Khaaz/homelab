#!/bin/sh

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
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

ROOT_DIR="$SCRIPT_DIR/.."

# Execute the command
if [ "$AUTO" = true ]; then
	# Execute with predefined arguments for automated mode
	$ROOT_DIR/preseed/create_preseed_iso.sh --preseed-cfg 
else
	# Pass through all parameters
	$ROOT_DIR/preseed/create_preseed_iso.sh "$@"
fi
