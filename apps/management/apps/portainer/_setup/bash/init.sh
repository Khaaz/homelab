#!/bin/sh

# doc: https://app.swaggerhub.com/apis/portainer/portainer-ce/2.35.0

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Requirements: curl, jq
apk add curl jq

"${SCRIPT_DIR}/setup_settings.sh"
"${SCRIPT_DIR}/create_environment.sh"
