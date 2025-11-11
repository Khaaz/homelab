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
	echo "Usage: $0 <target> --command <sys_info|ram_usage|cpu_usage|disk_usage>"
	echo "   or: $0 <target> --raw <linux command>"
	exit 1
}

## Input verification
TARGET=""
RAW_COMMAND=""
PREDEFINED_COMMAND=""

while [ $# -gt 0 ]; do
	case "$1" in
		--raw)
			shift
			RAW_COMMAND="$1"
			;;
		--command)
			shift
			if [ "$1" = "sys_info" ] || [ "$1" = "ram_usage" ] || [ "$1" = "cpu_usage" ] || [ "$1" = "disk_usage" ]; then
				PREDEFINED_COMMAND="$1"
			else
				usage
			fi
			;;
		--help)
			usage
			;;
		*)
			TARGET="$1"
			;;
	esac
	shift
done

if [ -z "$TARGET" ]; then
	usage
fi

if [ -z "$PREDEFINED_COMMAND" ] && [ -z "$RAW_COMMAND" ]; then
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

ARGS=""
if [ -n "$PREDEFINED_COMMAND" ]; then
	ARGS="--command $PREDEFINED_COMMAND"
else
	cmd_b64=$(printf "%s" "$RAW_COMMAND" | base64 -w 0 2>/dev/null || printf "%s" "$RAW_COMMAND" | base64)
	ARGS="--raw $cmd_b64"
fi

ssh -i $SCRIPT_DIR/../config/ssh/jump/admin_key \
    -o StrictHostKeyChecking=no \
	-p 2222 \
	-t \
    admin@$IP_SERVER \
	"/home/admin/homelab/apps/jump/exec_command.sh $TARGET $ARGS"


