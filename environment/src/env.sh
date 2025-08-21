#!/bin/sh

# Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ACTION=""
while [ $# -gt 0 ]; do
	case "$1" in
		up|down)
			ACTION="$1"
			;;
		*)
			echo "Unknown argument: $1"
			echo "Usage: $0 up|down"
			exit 1
			;;
	esac
	shift
done

if [ -z "$ACTION" ]; then
	echo "Usage: $0 up|down"
	exit 1
fi

case "$ACTION" in
    up)
		docker compose -f $SCRIPT_DIR/docker-compose.yml run --rm --build environment
		;;
	down)
		docker compose -f $SCRIPT_DIR/docker-compose.yml down environment 
		;;
esac
