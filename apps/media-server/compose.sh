#!/bin/sh

## Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
usage() {
	echo "Usage: $0 [--proxmox] [compose options...] <compose command> [compose options...]"
	echo "  --proxmox: Use proxmox IP from infra/proxmox.yml files (get_proxmox_ip.sh)"
	echo "           If not specified, uses ip from infra/local.env* files"
	echo "  compose command: Docker compose command (up, down, restart...)"
	echo "  compose options: Additional arguments passed to docker compose"
	exit 1
}

## Input verification
LOCAL_FLAG="true"
COMMAND=""
while [ $# -gt 0 ]; do
	case "$1" in
		--proxmox)
			LOCAL_FLAG="false"
			shift
			;;
		--help)
			usage
			;;
		*)
			if [ -z "$COMMAND" ]; then
				COMMAND="$1"
			else
				COMMAND="$COMMAND $1"
			fi
			shift
			;;
	esac
done

if [ -z "$COMMAND" ]; then
	usage
fi

#
## Core
#
add_env_file() {
	[ -f "$1" ] && echo "--env-file $1"
}

source_ips() {
	SOURCED_SCRIPT_DIR="$SCRIPT_DIR/src"
	. "$SCRIPT_DIR/src/source_apps_ip.sh"
}

# compose envs
DEFAULT_ENV_FILE="$SCRIPT_DIR/config/.env.default"
GENERATED_ENV_FILE="$SCRIPT_DIR/config/.env.generated"
OVERRIDE_ENV_FILE="$SCRIPT_DIR/config/.env"
NETWORKING_ENV_FILE="$SCRIPT_DIR/config/networking.env.default"
NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/config/networking.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/config/networking.env.default"
MM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-management/config/networking.env"

# source
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

# Set the default environment file path
export ROOT_PATH=$SCRIPT_DIR
echo "Root: $SCRIPT_DIR"

if [ "$LOCAL_FLAG" = "true" ]; then
	LOCAL_ARG="--local"
fi
echo "Sourcing IPs"
source_ips $LOCAL_ARG

docker compose -f $COMPOSE_FILE \
	--env-file $DEFAULT_ENV_FILE \
	--env-file $NETWORKING_ENV_FILE $(add_env_file "$NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $MM_NETWORKING_ENV_FILE $(add_env_file "$MM_NETWORKING_OVERRIDE_ENV_FILE") \
	$(add_env_file "$GENERATED_ENV_FILE") $(add_env_file "$OVERRIDE_ENV_FILE") \
	$COMMAND
