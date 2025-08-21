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

CLOUD_NETWORKING_ENV_FILE="$SCRIPT_DIR/../cloud/src/config/networking.env.default"
CLOUD_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../cloud/src/config/networking.env"
HA_NETWORKING_ENV_FILE="$SCRIPT_DIR/../home-automation/src/config/networking.env.default"
HA_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../home-automation/src/config/networking.env"
IM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../immich/src/config/networking.env.default"
IM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../immich/src/config/networking.env"

MM_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.env.default"
MM_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-management/src/config/networking.env"
MS_NETWORKING_ENV_FILE="$SCRIPT_DIR/../media-server/src/config/networking.env.default"
MS_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../media-server/src/config/networking.env"

NAS_NETWORKING_ENV_FILE="$SCRIPT_DIR/../nas/src/config/networking.env.default"
NAS_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../nas/src/config/networking.env"

NOTES_NETWORKING_ENV_FILE="$SCRIPT_DIR/../notes/src/config/networking.env.default"
NOTES_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../notes/src/config/networking.env"
TODO_NETWORKING_ENV_FILE="$SCRIPT_DIR/../todo/src/config/networking.env.default"
TODO_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../todo/src/config/networking.env"

VAULT_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vault/src/config/networking.env.default"
VAULT_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vault/src/config/networking.env"
VSC_NETWORKING_ENV_FILE="$SCRIPT_DIR/../vscode-server/src/config/networking.env.default"
VSC_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../vscode-server/src/config/networking.env"

WB_NETWORKING_ENV_FILE="$SCRIPT_DIR/../white-board/src/config/networking.env.default"
WB_NETWORKING_OVERRIDE_ENV_FILE="$SCRIPT_DIR/../white-board/src/config/networking.env"

# source
COMPOSE_FILE="$SCRIPT_DIR/src/docker-compose.yaml"

# Set the default environment file path
export ROOT_PATH=$SCRIPT_DIR
echo "Root: $SCRIPT_DIR"

docker compose -f $COMPOSE_FILE \
	--env-file $DEFAULT_ENV_FILE \
	--env-file $NETWORKING_ENV_FILE --env-file $NETWORKING_OVERRIDE_ENV_FILE \
	--env-file $CLOUD_NETWORKING_ENV_FILE $(add_env_file "$CLOUD_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $HA_NETWORKING_ENV_FILE $(add_env_file "$HA_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $IM_NETWORKING_ENV_FILE $(add_env_file "$IM_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $MM_NETWORKING_ENV_FILE $(add_env_file "$MM_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $MS_NETWORKING_ENV_FILE $(add_env_file "$MS_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $NAS_NETWORKING_ENV_FILE $(add_env_file "$NAS_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $NOTES_NETWORKING_ENV_FILE $(add_env_file "$NOTES_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $TODO_NETWORKING_ENV_FILE $(add_env_file "$TODO_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $VAULT_NETWORKING_ENV_FILE $(add_env_file "$VAULT_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $VSC_NETWORKING_ENV_FILE $(add_env_file "$VSC_NETWORKING_OVERRIDE_ENV_FILE") \
	--env-file $WB_NETWORKING_ENV_FILE $(add_env_file "$WB_NETWORKING_OVERRIDE_ENV_FILE") \
	$(add_env_file "$GENERATED_ENV_FILE") $(add_env_file "$OVERRIDE_ENV_FILE") \ 
	$COMMAND "$@"
