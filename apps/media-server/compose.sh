#!/bin/sh

COMMAND="$1"
shift

if [ "$COMMAND" != "up" ] && [ "$COMMAND" != "down" ]; then
    echo "Error: First argument must be 'up' or 'down'."
    exit 1
fi

SCRIPT_DIR=$(dirname "$(realpath "$0")")

# compose envs
DEFAULT_ENV_FILE="$SCRIPT_DIR/src/config/default.env"
NETWORKING_ENV_FILE="$SCRIPT_DIR/src/config/networking.env"
OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/config/.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.env"

# source
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

# Set the default environment file path
export ROOT_PATH=$SCRIPT_DIR
echo "Root: $SCRIPT_DIR"

docker compose -f $COMPOSE_FILE --env-file $DEFAULT_ENV_FILE --env-file $NETWORKING_ENV_FILE --env-file $MM_NETWORKING_ENV_FILE --env-file $OVERRIDE_ENV_FILE $COMMAND "$@"