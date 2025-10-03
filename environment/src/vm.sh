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
	echo "Usage: $0 <up|down|reload> [--provider|-p <virtualbox|hyperv|vmware>]"
	exit 1
}

## Input verification
PROVIDER="virtualbox"
ACTION=""
while [ $# -gt 0 ]; do
	case "$1" in
		up|down|reload)
			ACTION="$1"
			;;
		--provider|-p)
			shift
			PROVIDER="$1"
			;;
		--help)
			usage
			;;
		*)
			echo "Unknown argument: $1"
			usage
			;;
	esac
	shift
done

if [ -z "$ACTION" ]; then
	usage
fi

#
## Core
#
cd "$SCRIPT_DIR/../vagrant"

case "$ACTION" in
	up)
		vagrant up --provider "$PROVIDER"
		;;
	down)
		vagrant destroy -f
		;;
	reload)
		vagrant reload
		;;
esac
