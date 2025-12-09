#!/bin/bash

# Doc: https://api.jellyfin.org/

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Install jq if missing
if ! command -v jq &> /dev/null; then
    echo "LOG: Installing jq..."
    apt-get update && apt-get install -y jq
fi

## Run setup wizard
"${SCRIPT_DIR}/init_setup_wizard.sh"

## Run plugins install
"${SCRIPT_DIR}/init_plugins.sh"
