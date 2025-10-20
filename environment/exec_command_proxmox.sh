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
	echo "Usage: $0 --command \"<shutdown|reboot|reset>\" [--dev]"
	echo "--command: Executes the command on the proxmox node"
	echo "  shutdown: Shuts down the proxmox node"
	echo "  reboot: Reboots the proxmox node"
	echo "  reset: Resets entirely the proxmox to blank setup (preseeded)"
	echo "--dev: Executes the command on the VM. Otherwise will target the 'real' server"
	exit 1
}

## Input verification
DEV=false
COMMAND=""
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			shift
			;;
		--command)
			COMMAND=$2
			shift 2
			;;
		--help)
			usage
			;;
		*)
			usage
			;;
	esac
done

if [ "$COMMAND" != "shutdown" ] && [ "$COMMAND" != "reboot" ] && [ "$COMMAND" != "reset" ]; then
	usage
fi

# Ask confirmation for destructive actions
if [ "$COMMAND" = "reset" ]; then
	printf "This will RESET the proxmox node to a blank preseeded state. Type 'reset' to confirm: "
	read confirmation
	if [ "$confirmation" != "reset" ]; then
		echo "Aborted."
		exit 1
	fi
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

# Execute the command
$ROOT_DIR/iac/1.setup_proxmox.sh "$COMMAND" $DEV_ARGS "$@"
