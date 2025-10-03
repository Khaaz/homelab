#!/bin/sh

## Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

IAC_FOLDER="$SCRIPT_DIR/.."
PACKER_FOLDER="$IAC_FOLDER/packer"

## Usage
usage() {
	echo "Usage: $0 [--dev]"
	exit 1
}

## Input verification
DEV=false
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			;;
		--help)
			usage
			;;
	esac
	shift
done

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
ENV_FILE="$IAC_FOLDER/config/.env"
GENERATED_ENV_FILE="$IAC_FOLDER/config/.env.generated"
PACKER_ENV_FILE="$IAC_FOLDER/config/packer.env"

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
if [ "$ENV_LOADED" = false ]; then
	echo "Warning: No env file found: $GENERATED_ENV_FILE or $ENV_FILE"
	exit 1
fi
if [ -f "$PACKER_ENV_FILE" ]; then
	set -a
	. "$PACKER_ENV_FILE"
	set +a
else
	echo "Warning: No packer.env file found: $PACKER_ENV_FILE"
	exit 1
fi

# Logs and debug mode
export PACKER_LOG=1
export PACKER_LOG_LEVEL=TRACE
export PACKER_LOG_PATH="$PACKER_FOLDER/logs/packer.log"

# remap env var:
export PROXMOX_PACKER_TOKEN_ID=$PACKER_TOKEN_ID
export PROXMOX_PACKER_TOKEN_SECRET=$PACKER_TOKEN_SECRET
if [ "$DEV" = true ]; then
	export DEV_MODE="true"
fi

cd $PACKER_FOLDER
packer init $PACKER_FOLDER
packer build $PACKER_FOLDER
