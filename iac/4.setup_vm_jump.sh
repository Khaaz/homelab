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
	echo "Usage: $0 <playbook> [--refresh-config <none|config|full>] [--refresh-ssh <none|new|full|generate|reset>] [--help]"
	echo
	echo "Options:"
	echo "  --refresh-config, -rc  Set config refresh level (default: config)"
	echo "    - none    : do nothing"
	echo "    - config  : copy global-config.toml and run environment/generate_env.sh --auto"
	echo "    - full    : also copy .env and networking.env from controller root (override if present)"
	echo
	echo "  --refresh-ssh, -rs     Set SSH refresh level (default: new)"
	echo "    - none     : do nothing"
	echo "    - new      : copy keys only if missing on target"
	echo "    - full     : copy all SSH keys"
	echo "    - generate : run environment/generate_ssh_keys.sh --auto"
	echo "    - reset    : run environment/generate_ssh_keys.sh --auto --reset"
	echo
	echo "Examples:"
	echo "  $0 --refresh-config config --refresh-ssh new"
	echo "  $0 -rc full -rs reset"

	exit 1
}

## Input verification
REFRESH_CONFIG="full"
REFRESH_SSH="new"
PLAYBOOK="setup"
while [ $# -gt 0 ]; do
	case "$1" in
		--refresh-config|-rc)
			REFRESH_CONFIG=$2
			shift 2
			;;
		--refresh-ssh|-rs)
			REFRESH_SSH=$2
			shift 2
			;;
		--help)
			usage
			;;
		*)
			PLAYBOOK=$1
			shift
			;;
	esac
done

if [ -z "$PLAYBOOK" ]; then
	usage
fi

#
## Core
#
# Execute the command
$SCRIPT_DIR/src/ansible.sh "jump/$PLAYBOOK" -e "refresh_config=$REFRESH_CONFIG refresh_ssh=$REFRESH_SSH" "$@"
