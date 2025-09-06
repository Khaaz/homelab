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
	esac
done

if [ "$AUTO" = false ] && [ -z "$1" ]; then
	usage
fi

#
## Core
#
DEV_ARGS=""
if [ "$DEV" = true ]; then
	DEV_ARGS="--limit vm"
else
	DEV_ARGS="--limit homelab-node1"
fi

PLAYBOOK_ARGS=""
if [ "$AUTO" = true ]; then
	PLAYBOOK_ARGS="proxmox-setup"
else
	PLAYBOOK_ARGS=$1
fi

# Execute the command
$ROOT_DIR/iac/1.setup_proxmox.sh "$DEV_ARGS" "$PLAYBOOK_ARGS" "$@"
