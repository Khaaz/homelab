#!/bin/sh

# Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Core
# Source environment variables from ./config/.env (standard env file)
ENV_FILE="$SCRIPT_DIR/config/.env"
if [ -f "$ENV_FILE" ]; then
	set -a
	. "$ENV_FILE"
	set +a
else
  	echo "Warning: Env file not found: $ENV_FILE"
fi

PACKER_FOLDER="$SCRIPT_DIR/../packer"

# Logs and debug mode
export PACKER_LOG=1
export PACKER_LOG_LEVEL=TRACE
export PACKER_LOG_PATH="$PACKER_FOLDER/logs/packer.log"

cd $PACKER_FOLDER
packer init $PACKER_FOLDER
packer build $PACKER_FOLDER
