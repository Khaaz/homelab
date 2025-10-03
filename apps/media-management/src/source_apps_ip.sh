#!/bin/sh

## Prerequisites
get_script_dir() {
	if [ -n "$SOURCED_SCRIPT_DIR" ]; then
		echo "$SOURCED_SCRIPT_DIR"
	else
		# Get the directory of the currently running script
		local script_dir=$(dirname "$(realpath "$0")")
		echo "$script_dir"
	fi
}
SCRIPT_DIR=$(get_script_dir)
ROOT_DIR="$SCRIPT_DIR/../../.."

## Usage
usage() {
	echo "Usage: $0 [--local]"
	echo "  --local: Use local IP from apps/<appname>/infra/local.env files"
	echo "           If not specified, uses get_proxmox_ip.sh to retrieve IP from infra/proxmox.yml"
	exit 1
}

## Input verification
LOCAL_FLAG=""
while [ $# -gt 0 ]; do
	case "$1" in
		--local) 
			LOCAL_FLAG="true"
			shift
			;;
		--help) 
			usage
			;;
		*) 
			usage
			;;
	esac
done

#
## Core
#
# Construct local argument dynamically
LOCAL_ARG=""
if [ "$LOCAL_FLAG" = "true" ]; then
	LOCAL_ARG="--local"
fi

# Source the source_app_ip.sh script for each app with dynamic local argument
# This runs the script in the current shell context so exports are preserved
# Export "SOURCED_SCRIPT_DIR" in to preserve path
source_app_ip() {
	local env_var_name=$(echo "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_')_IP

	local ip=$("$ROOT_DIR/src/app-bootstrap/get_app_ip.sh" --for "$1" --on "$2" $LOCAL_ARG)
	export "$env_var_name"="$ip"
	echo "$env_var_name=$ip"
}


echo "Sourcing environment variables:"
source_app_ip media-server vmbr3
