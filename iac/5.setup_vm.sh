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
	echo "Usage: $0 <playbook> --app <app_name> --ip <ip> --key <path_to_key> [--refresh-config <none|generated|full>] [--help]"
	echo
	echo "Options:"
	echo "  --refresh-config, -rc  Set config refresh level (default: full)"
	echo "    - none      : do nothing"
	echo "    - generated : copy .env.generated"
	echo "    - full      : also copy .env and networking.env from controller root (override if present)"
	echo
	echo "Examples:"
	echo "  $0 --refresh-config config --ip 10.10.30.2 --key /workspace/config/ssh/reverse-proxy/automation_key"
	echo "  $0 -rc full --ip 10.10.30.2 --key /workspace/config/ssh/reverse-proxy/automation_key"

	exit 1
}

## Input verification
PLAYBOOK="setup"
REFRESH_CONFIG="full"
APP=""
IP=""
KEY=""
while [ $# -gt 0 ]; do
	case "$1" in
		--refresh-config|-rc)
			REFRESH_CONFIG=$2
			shift 2
			;;
		--app)
			APP=$2
			shift 2
			;;
		--ip)
			IP=$2
			shift 2
			;;
		--key)
			KEY=$2
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

if [ -z "$PLAYBOOK" ] || [ -z "$APP" ] || [ -z "$IP" ] || [ -z "$KEY" ]; then
	usage
fi

#
## Core
#
# Execute the command
$SCRIPT_DIR/src/ansible.sh "vm/$PLAYBOOK" --private-key "$KEY" --i "$IP" -e "app_name=$APP refresh_config=$REFRESH_CONFIG" "$@"
