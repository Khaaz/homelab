#!/bin/sh

## Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

IAC_FOLDER="$SCRIPT_DIR/.."
ANSIBLE_FOLDER="$SCRIPT_DIR/../ansible"

## Usage
usage() {
	echo "Usage: $0 <playbook_name> [--limit <host>] [-e <extra_vars>]"
	exit 1
}

## Input verification
if [ -z "$1" ]; then
	usage
fi
PLAYBOOK_NAME="$1"
shift

# Check if the playbook file exists
PLAYBOOK_PATH="$ANSIBLE_FOLDER/playbooks/$PLAYBOOK_NAME.playbook.yml"
if [ ! -f "$PLAYBOOK_PATH" ]; then
	echo "Error: Playbook file does not exist: $PLAYBOOK_PATH"
	exit 1
fi

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
ENV_FILE="$IAC_FOLDER/config/.env"
GENERATED_ENV_FILE="$IAC_FOLDER/config/.env.generated"

ENV_LOADED=false
if [ -f "$GENERATED_ENV_FILE" ]; then
	set -a
	. "$GENERATED_ENV_FILE"
	set +a
	ENV_LOADED=true
fi
if [ -f "$ENV_FILE" ]; then
	set -a
	. "$ENV_FILE"
	set +a
	ENV_LOADED=true
fi
if [ "$ENV_LOADED" = false ] && [ "$PLAYBOOK_NAME" != "jump/pull-config" ]; then
	echo "Warning: No env file found: $GENERATED_ENV_FILE or $ENV_FILE"
	exit 1
fi

cd $ANSIBLE_FOLDER

ansible-playbook "$@" "$PLAYBOOK_PATH"
