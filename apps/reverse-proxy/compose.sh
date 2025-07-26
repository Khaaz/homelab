#!/bin/sh

COMMAND="$1"
shift

if [ "$COMMAND" != "up" ] && [ "$COMMAND" != "down" ]; then
    echo "Error: First argument must be 'up' or 'down'."
    exit 1
fi

SCRIPT_DIR=$(dirname "$(realpath "$0")")

add_env_file() {
  [ -f "$1" ] && echo "--env-file $1"
}

# compose envs
DEFAULT_ENV_FILE="$SCRIPT_DIR/src/config/default.env"
OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/config/.env"
NETWORKING_ENV_FILE="$SCRIPT_DIR/src/config/networking.default.env"
NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/config/networking.env"

CLD_NETWORKING_ENV_FILE="$SCRIPT_DIR/../cloud/src/config/networking.default.env"
CLD_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../cloud/src/config/networking.env"
HA_NETWORKING_ENV_FILE="$SCRIPT_DIR/../home-automation/src/config/networking.default.env"
HA_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../home-automation/src/config/networking.env"
IM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../immich/src/config/networking.default.env"
IM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../immich/src/config/networking.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.default.env"
MM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.env"
MS_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-server/src/config/networking.default.env"
MS_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-server/src/config/networking.env"

VLT_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vault/src/config/networking.default.env"
VLT_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vault/src/config/networking.env"
VSC_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vscode-server/src/config/networking.default.env"
VSC_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vscode-server/src/config/networking.env"

# source
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

# Set the default environment file path
export ROOT_PATH=$SCRIPT_DIR
echo "Root: $SCRIPT_DIR"

docker compose -f $COMPOSE_FILE \
    --env-file $DEFAULT_ENV_FILE \
    --env-file $NETWORKING_ENV_FILE --env-file $NETWORKING_OVERRIDE_ENV_FILE \
    --env-file $CLD_NETWORKING_ENV_FILE $(add_env_file "$CLD_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $HA_NETWORKING_ENV_FILE $(add_env_file "$HA_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $IM_NETWORKING_ENV_FILE $(add_env_file "$IM_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $MM_NETWORKING_ENV_FILE $(add_env_file "$MM_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $MS_NETWORKING_ENV_FILE $(add_env_file "$MS_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $VLT_NETWORKING_ENV_FILE $(add_env_file "$VLT_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $VSC_NETWORKING_ENV_FILE $(add_env_file "$VSC_NETWORKING_OVERRIDE_ENV_FILE") \
    --env-file $OVERRIDE_ENV_FILE $COMMAND \
    "$@"