#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
usage() {
	echo "Usage: $0 <vm>"
	exit 1
}

## Input verification
if [ -z  "$1" ]; then
	usage
fi

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
# config/.env.default (default env file)
ENVIRONMENT_CONFIG_FOLDER="$SCRIPT_DIR/config"
ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/.env"
GENERATED_ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/.env.generated"
DEFAULT_ENV_FILE="$ENVIRONMENT_CONFIG_FOLDER/.env.default"

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

if [ "$1" = "jump" ]; then
	$SCRIPT_DIR/ssh_jump.sh
else
	# Execute command directely via jump / resolve vm name via dns
	ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
		-o StrictHostKeyChecking=no \
		-p 2222 \
		-t \
		admin@$IP_SERVER \
		"./homelab/apps/jump/ssh_vm.sh $1"
fi
