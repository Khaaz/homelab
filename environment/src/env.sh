#!/bin/sh

# Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ACTION=""
PACKER_PORT=""
while [ $# -gt 0 ]; do
	case "$1" in
		up|down)
			ACTION="$1"
			;;
		--packer)
			PACKER_PORT="-p 8098:8098"
			;;
		*)
			echo "Unknown argument: $1"
			echo "Usage: $0 up|down [--packer]"
			exit 1
			;;
	esac
	shift
done

if [ -z "$ACTION" ]; then
	echo "Usage: $0 up|down [--packer]"
	exit 1
fi

case "$ACTION" in
    up)
		# --rm remove the container
		# --service-ports publish all ports (mimic "normal" docker compose up behaviour)
		# --packer adds specific port mapping for Packer HTTP server
		docker compose -f $SCRIPT_DIR/docker-compose.yml run --rm --build $PACKER_PORT environment
		;;
	down)
		docker compose -f $SCRIPT_DIR/docker-compose.yml down environment 
		;;
esac
