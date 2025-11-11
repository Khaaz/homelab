#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ENVIRONMENT_CONFIG_FOLDER="$SCRIPT_DIR/config"

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
# config/.env.default (default env file)
ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/config/.env"
GENERATED_ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/config/.env.generated"
DEFAULT_ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/config/.env.default"

if [ -f "$DEFAULT_ENV_FILE" ]; then
	set -a
	. "$DEFAULT_ENV_FILE"
	set +a
fi
if [ -f "$GENERATED_ENV_FILE" ]; then
	set -a
	. "$GENERATED_ENV_FILE"
	set +a
fi
if [ -f "$ENV_FILE" ]; then
	set -a
	. "$ENV_FILE"
	set +a
fi

LOCATE="cd /home/admin/homelab/apps/jump 2> /dev/null"

ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
    -o StrictHostKeyChecking=no \
	-p 2222 \
	-t \
    admin@$IP_SERVER \
	"$LOCATE; exec "'$SHELL'
