#!/bin/sh

COMMAND="$1"
shift

if [ "$COMMAND" != "up" ] && [ "$COMMAND" != "down" ]; then
    echo "Error: First argument must be 'up' or 'down'."
    exit 1
fi

# Get the directory where the script is located
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Set the default environment file path
DEFAULT_ENV_FILE="$SCRIPT_DIR/src/default.env"
OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/secret.env"
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

echo $SCRIPT_DIR

export ROOT_PATH=$SCRIPT_DIR
docker compose -f $COMPOSE_FILE --env-file $DEFAULT_ENV_FILE --env-file $OVERRIDE_ENV_FILE $COMMAND "$@"