#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

$SCRIPT_DIR/generate_env.sh --auto
$SCRIPT_DIR/generate_ssh_keys.sh --auto
