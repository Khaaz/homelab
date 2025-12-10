#!/bin/bash

# Doc: https://api.jellyfin.org/

## Configuration
JELLYFIN_URL="http://127.0.0.1:8096"

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Install jq if missing
if ! command -v jq &> /dev/null; then
    echo "LOG: Installing jq..."
    apt-get update && apt-get install -y jq
fi

## Wait for Jellyfin to be ready
wait_for_jellyfin() {
    echo "INFO: Waiting for Jellyfin to be responsive..."
    until curl -s "$JELLYFIN_URL/System/Ping" >/dev/null; do
        sleep 5
    done
    echo "INFO: Jellyfin is up."
}

wait_for_jellyfin

# Additional sleep to make sure jellyfin is entirely ready
sleep 15

## Run setup wizard
echo "======== Setup Wizard ========"
"${SCRIPT_DIR}/init_setup_wizard.sh"

## Run plugins install
echo "======== Plugins Install ========"
"${SCRIPT_DIR}/init_plugins.sh"
