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
			COMMAND="$COMMAND $1"
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

CLOUD_NETWORKING_ENV_FILE="$SCRIPT_DIR/../cloud/config/networking.env.default"
CLOUD_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../cloud/config/networking.env"
HA_NETWORKING_ENV_FILE="$SCRIPT_DIR/../home-automation/config/networking.env.default"
HA_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../home-automation/config/networking.env"
IM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../immich/config/networking.env.default"
IM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../immich/config/networking.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/config/networking.env.default"
MM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-management/config/networking.env"
MS_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-server/config/networking.env.default"
MS_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-server/config/networking.env"

# NAS_NETWORKING_ENV_FILE="$SCRIPT_DIR/../nas/config/networking.env.default"
# NAS_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../nas/config/networking.env"

NOTES_NETWORKING_ENV_FILE="$SCRIPT_DIR/../notes/config/networking.env.default"
NOTES_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../notes/config/networking.env"
TODO_NETWORKING_ENV_FILE="$SCRIPT_DIR/../todo/config/networking.env.default"
TODO_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../todo/config/networking.env"

VAULT_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vault/config/networking.env.default"
VAULT_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vault/config/networking.env"
VPN_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vpn/config/networking.env.default"
VPN_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vpn/config/networking.env"
VSC_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vscode-server/config/networking.env.default"
VSC_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vscode-server/config/networking.env"

WB_NETWORKING_ENV_FILE="$SCRIPT_DIR/../whiteboard/config/networking.env.default"
WB_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../whiteboard/config/networking.env"

# proxmox env
PROXMOX_ENV_FILE="$SCRIPT_DIR/config/proxmox.env"

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

# If running with proxmox flag, include proxmox.env if present
PROXMOX_ENV_ARG=""
if [ "$LOCAL_FLAG" = "false" ]; then
	PROXMOX_ENV_ARG=$(add_env_file "$PROXMOX_ENV_FILE")
fi

docker compose -f $COMPOSE_FILE \
	--env-file $DEFAULT_ENV_FILE \
	--env-file $NETWORKING_ENV_FILE $(add_env_file "$NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $CLOUD_NETWORKING_ENV_FILE $(add_env_file "$CLOUD_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $HA_NETWORKING_ENV_FILE $(add_env_file "$HA_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $IM_NETWORKING_ENV_FILE $(add_env_file "$IM_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $MM_NETWORKING_ENV_FILE $(add_env_file "$MM_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $MS_NETWORKING_ENV_FILE $(add_env_file "$MS_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $NOTES_NETWORKING_ENV_FILE $(add_env_file "$NOTES_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $TODO_NETWORKING_ENV_FILE $(add_env_file "$TODO_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $VAULT_NETWORKING_ENV_FILE $(add_env_file "$VAULT_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $VPN_NETWORKING_ENV_FILE $(add_env_file "$VPN_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $VSC_NETWORKING_ENV_FILE $(add_env_file "$VSC_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $WB_NETWORKING_ENV_FILE $(add_env_file "$WB_NETWORKING_OVERRIDE_ENV_FILE") \
	$PROXMOX_ENV_ARG \
	$(add_env_file "$GENERATED_ENV_FILE") $(add_env_file "$OVERRIDE_ENV_FILE") \
	$COMMAND
