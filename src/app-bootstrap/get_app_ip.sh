#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)
ROOT_DIR="$SCRIPT_DIR/../.."

## Usage
usage() {
	echo "Usage: $0 --for <app-name> --on <bridge-name[.vlan-id]> [--local]"
	echo "  --for: App name (mandatory)"
	echo "  --on:  Network bridge name, optionally with VLAN (mandatory)"
	echo "  --local: Use local IP from apps/<appname>/infra/local.env files"
	echo "           If not specified, uses get_ip.sh to retrieve IP from proxmox.yml"
	echo "Eg: $0 --for firewall-gw --on vmbr1"
	echo "Eg: $0 --for reverse-proxy --on vmbr3.30"
	echo "Eg: $0 --for media-server --on vmbr3.31"
	echo "..."
	echo "Pass a VERBOSE=true environment variable to get verbose output"
	exit 1
}

## Input verification
APP=""
ON=""
LOCAL_FLAG="false"
while [ $# -gt 0 ]; do
	case "$1" in
		--for) 
			APP="$2"
			shift 2
			;;
		--on)  
			ON="$2" 
			shift 2
			;;
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

[ -n "${APP:-}" ] || usage
[ -n "${ON:-}" ]  || usage

#
## Core
#
# Function to get app IP and return it
get_app_ip() {
	local app_name="$1"
	local network="$2"
	local ip=""
	
	if [ "$LOCAL_FLAG" = "true" ]; then
		# Use local IP from local.env files
		local local_env_default="$ROOT_DIR/apps/$app_name/infra/local.env.default"
		local local_env_generated="$ROOT_DIR/apps/$app_name/infra/local.env.generated"
		local local_env="$ROOT_DIR/apps/$app_name/infra/local.env"
		
		
		# Check if local.env.default exists and read IP
		if [ -f "$local_env_default" ]; then
			ip=$(grep "^IP=" "$local_env_default" | cut -d'=' -f2 | tr -d '"')
		fi
		
		# Override with local.env if it exists
		if [ -f "$local_env_generated" ]; then
			ip=$(grep "^IP=" "$local_env_generated" | cut -d'=' -f2 | tr -d '"')
		fi
		
		# Override with local.env if it exists
		if [ -f "$local_env" ]; then
			ip=$(grep "^IP=" "$local_env" | cut -d'=' -f2 | tr -d '"')
		fi
		
		if [ -z "$ip" ]; then
			echo "Error: No IP found in local.env files for app: $app_name" >&2
			return 1
		fi
		
		if [ "$VERBOSE" = "true" ]; then
			echo "Using local IP for $app_name: $ip" >&2
		fi
		echo "$ip"
	else
		# Use get_ip.sh to retrieve IP from proxmox.yml
		ip=$("$SCRIPT_DIR/get_proxmox_ip.sh" --for "$app_name" --on "$network")
		if [ $? -ne 0 ]; then
			echo "Error: Failed to get IP for app: $app_name on network: $network" >&2
			return 1
		fi
		
		if [ "$VERBOSE" = "true" ]; then
			echo "Retrieved IP for $app_name on $network: $ip" >&2
		fi
		echo "$ip"
	fi
}

# Execute the function for the specified app and network
get_app_ip "$APP" "$ON"
