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
	echo "Usage: $0"
	echo "  --local: Use local IP from apps/<appname>/infra/local.env files"
	echo "           If not specified, uses get_proxmox_ip.sh to retrieve IP from infra/proxmox.yml"
	exit 1
}

## Input verification
LOCAL_FLAG="false"
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

# Get the ip via proxmox.yml file and export it as the appropriate env var
source_app_ip() {
	local env_var_name=$(echo "$1" | tr '[:lower:]' '[:upper:]' | tr '-' '_')_IP

	local ip=$("$ROOT_DIR/src/app-bootstrap/get_app_ip.sh" --for "$1" --on "$2" $LOCAL_ARG)
	export "$env_var_name"="$ip"
	echo "$env_var_name=$ip" >&2
}


echo "Sourcing environment variables:" >&2
source_app_ip cloud vmbr3
source_app_ip dns vmbr1
source_app_ip firewall-gw vmbr1
source_app_ip firewall-mgmt vmbr2
source_app_ip firewall-srv vmbr3.31
source_app_ip home-automation vmbr3
source_app_ip immich vmbr3
source_app_ip jump vmbr2
source_app_ip media-management vmbr3
source_app_ip media-server vmbr3
source_app_ip nas vmbr3
source_app_ip notes vmbr3
source_app_ip reverse-proxy vmbr3.30
source_app_ip sandbox vmbr3
source_app_ip todo vmbr3
source_app_ip vault vmbr3
source_app_ip vpn vmbr2
source_app_ip vscode-server vmbr3
source_app_ip white-board vmbr3
