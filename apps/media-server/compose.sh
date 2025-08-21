#!/bin/sh

COMMAND="$1"
shift

if [ "$COMMAND" != "up" ] && [ "$COMMAND" != "down" ]; then
	echo "Error: First argument must be 'up' or 'down'."
	exit 1
fi

get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

add_env_file() {
	[ -f "$1" ] && echo "--env-file $1"
}

# compose envs
DEFAULT_ENV_FILE="$SCRIPT_DIR/src/config/.env.default"
GENERATED_ENV_FILE="$SCRIPT_DIR/src/config/.env.generated"
OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/config/.env"
NETWORKING_ENV_FILE="$SCRIPT_DIR/src/config/networking.env.default"
NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/src/config/networking.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.default.env"
MM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.env"

# source
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

# Set the default environment file path
export ROOT_PATH=$SCRIPT_DIR
echo "Root: $SCRIPT_DIR"

docker compose -f $COMPOSE_FILE \
	--env-file $DEFAULT_ENV_FILE \
	--env-file $NETWORKING_ENV_FILE --env-file $NETWORKING_OVERRIDE_ENV_FILE \
	--env-file $MM_NETWORKING_ENV_FILE --env-file $MM_NETWORKING_OVERRIDE_ENV_FILE \
	$(add_env_file "$GENERATED_ENV_FILE") $(add_env_file "$OVERRIDE_ENV_FILE") \ 
	$COMMAND "$@"
