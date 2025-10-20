#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)
ROOT_DIR="$SCRIPT_DIR/../.."

## Usage
usage() {
	echo "Usage: $0 <target> --command <sys_info|ram_usage|cpu_usage|disk_usage>"
	echo "   or: $0 <target> --raw <base64-encoded-command>"
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
produce_payload() {
	if [ -n "$PREDEFINED_COMMAND" ]; then
		cat "$SCRIPT_DIR/utilities/$PREDEFINED_COMMAND.sh"
	else
		local cmd
		cmd=$(printf "%s" "$RAW_COMMAND" | base64 -d 2>/dev/null)
		if [ -z "$cmd" ]; then
			echo "Failed to decode --raw" >&2
			return 1
		fi
		printf '%s\n' "$cmd"
	fi
}

if [ "$TARGET" = "jump" ]; then
	produce_payload | sh -s
else
	TARGET_IP=$("$SCRIPT_DIR/src/get_vm_ip.sh" "$TARGET")

	produce_payload | ssh -i "$ROOT_DIR/config/ssh/$TARGET/admin_key" \
		-o StrictHostKeyChecking=no \
		-t \
		admin@"$TARGET_IP" \
		'sh -s'
fi
