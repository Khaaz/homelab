#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)


# Source the source_vms_ip.sh script
# This runs the script in the current shell context so exports are preserved
# Export "SOURCED_SCRIPT_DIR" in to preserve path
source_ips() {
	SOURCED_SCRIPT_DIR="$SCRIPT_DIR/src"
	. "$SCRIPT_DIR/source_vms_ip.sh"
}

$SCRIPT_DIR/src/test_connectivity.sh --for media-management --target media-server --with 10.10.31.11 --on 5000 --should work
$SCRIPT_DIR/src/test_connectivity.sh --for media-server --target media-management --with 10.10.32.10 --on 5000 --should work

$SCRIPT_DIR/src/test_connectivity.sh --for media-server --target media-management --with 10.10.31.11 --on 22 --should fail
$SCRIPT_DIR/src/test_connectivity.sh --for media-management --target media-server --with 10.10.32.10 --on 22 --should fail
