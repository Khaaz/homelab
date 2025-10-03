#!/bin/sh

## Prerequesites
get_script_dir() {
	 # Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ROOT_DIR="$SCRIPT_DIR/.."

## Usage
usage() {
	echo "Usage: $0 [<playbook>] [--auto] [--dev]"
	echo "If not in auto mode: specify a playbook to run (eg: test, proxmox/hardening, proxmox/setup-user...)"
	echo "--auto mode will run the default setup playbook (full setup)"
	echo "--dev mode will target the VM. Otherwise will target the 'real' server"
	exit 1
}

## Input verification
DEV=false
AUTO=false
PLAYBOOK_ARGS=""
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			shift
			;;
		--auto)
			AUTO=true
			shift
			;;
		--help)
			usage
			;;
		*)
			PLAYBOOK_ARGS=$1
			shift
			;;
	esac
done

if [ "$AUTO" = false ] && [ -z "$PLAYBOOK_ARGS" ]; then
	usage
fi

#
## Core
#
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--limit vm-local"
else
	DEV_ARGS="--limit proxmox-node1"
fi

if [ "$AUTO" = true ]; then
	PLAYBOOK_ARGS="setup"
fi

# Execute the command
$ROOT_DIR/iac/1.setup_proxmox.sh "$PLAYBOOK_ARGS" "$DEV_ARGS" "$@"
