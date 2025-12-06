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
LCL_SCRIPT_DIR=$(get_script_dir)
LCL_ROOT_DIR="$LCL_SCRIPT_DIR/../../.."

## Usage
usage() {
	echo "Usage: $0 [--local]"
	echo "  --local: Use local IP from apps/<appname>/infra/local.env files"
	echo "           If not specified, uses get_proxmox_ip.sh to retrieve IP from infra/proxmox.yml"
	echo "..."
	echo "Pass a VERBOSE=true environment variable to get verbose output"
	exit 1
}

## Input verification
LCL_LOCAL_FLAG="false"
while [ $# -gt 0 ]; do
	case "$1" in
		--local) 
			LCL_LOCAL_FLAG="true"
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
LCL_LOCAL_ARG=""
if [ "$LCL_LOCAL_FLAG" = "true" ]; then
	LCL_LOCAL_ARG="--local"
fi

# Source the source_app_ip.sh script for each app with dynamic local argument
# This runs the script in the current shell context so exports are preserved
# Export "SOURCED_SCRIPT_DIR" in to preserve path
source_app_ip() {
	local env_var_name=$(echo "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_')_IP

	local ip=$("$LCL_ROOT_DIR/src/app-bootstrap/get_app_ip.sh" --for "$1" --on "$2" $LCL_LOCAL_ARG)
	export "$env_var_name"="$ip"
	if [ "$VERBOSE" = "true" ]; then
		echo "$env_var_name=$ip"
	fi
}

echo "Sourcing environment variables:"
source_app_ip cloud vmbr3
source_app_ip dns vmbr1
source_app_ip firewall-gw vmbr1
source_app_ip firewall-mgmt vmbr2
source_app_ip firewall-srv vmbr3.31
source_app_ip home-automation vmbr3
source_app_ip immich vmbr3
source_app_ip jump vmbr2
source_app_ip management vmbr2
source_app_ip media-management vmbr3
source_app_ip media-server vmbr3
source_app_ip nas vmbr3
source_app_ip notes vmbr3
source_app_ip reverse-proxy vmbr3.30
source_app_ip sandbox vmbr3
source_app_ip vault vmbr3
source_app_ip vpn vmbr4
source_app_ip vscode-server vmbr3
source_app_ip whiteboard vmbr3
