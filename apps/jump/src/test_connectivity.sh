#!/bin/sh

## Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)
ROOT_DIR="$SCRIPT_DIR/../../.."

## Usage
usage() {
	echo "Usage: $0 --for <host_vm> --target <target_vm> --with <target_ip> --on <port> --should <work|fail>"
	echo "  Tests TCP connectivity from <host_vm> to <target_vm> (<target_ip>:<port>) over SSH."
	echo "  Example:"
	echo "    $0 --for media-management --target media-server --with 10.10.31.11 --on 5000 --should work"
	exit 1
}

## Input verification
HOST_VM=""
TARGET_VM=""
TARGET_IP=""
PORT=""
SHOULD=""
while [ $# -gt 0 ]; do
	case "$1" in
		--for)
			HOST_VM=$2; 
			shift 2 
			;;
		--target)
			TARGET_VM=$2; 
			shift 2 
			;;
		--with)
			TARGET_IP=$2; 
			shift 2 
			;;
		--on)
			PORT=$2; 
			shift 2 
			;;
		--should)
			if [ "$2" != "work" ] && [ "$2" != "fail" ]; then
				usage
			else
				SHOULD=$2;
			fi
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

if [ -z "$HOST_VM" ] || [ -z "$TARGET_VM" ] || [ -z "$TARGET_IP" ] || [ -z "$PORT" ] || [ -z "$SHOULD" ]; then
	usage
fi

#
## Core
#
HOST_IP=$("$SCRIPT_DIR/src/get_vm_ip.sh" "$HOST_VM")

TIMEOUT_SECS=5

## Listener / server
# Start remote listener on target in background (kept alive by SSH)
ssh -i $ROOT_DIR/config/ssh/$TARGET_VM/admin_key \
	-o ConnectTimeout=10 \
    -o StrictHostKeyChecking=no \
    -t \
	admin@$TARGET_IP \
	"nc -lnvp $PORT" >/dev/null 2>&1 &
LISTENER_TARGET_PID=$!

# Ensure cleanup of background SSH if we exit early
cleanup() {
	if [ -n "${LISTENER_TARGET_PID:-}" ]; then
		kill "$LISTENER_TARGET_PID" >/dev/null 2>&1 || true
		wait "$LISTENER_TARGET_PID" 2>/dev/null || true
	fi
}
trap cleanup EXIT INT TERM

# Give the listener a brief moment to bind
sleep 0.5

## Sender / client
# Execute the active test from host -> target
ssh -i $ROOT_DIR/config/ssh/$HOST_VM/admin_key \
	-o ConnectTimeout=10 \
    -o StrictHostKeyChecking=no \
    -t \
	admin@$HOST_IP \
	nc -nvz -w "$TIMEOUT_SECS" "$TARGET_IP" "$PORT" >/dev/null 2>&1

NC_RESULT=$?

# Stop the background listener SSH
cleanup
trap - EXIT INT TERM

## Evaluate result
WORKED=false
if [ "$NC_RESULT" -eq 0 ]; then
	WORKED=true
fi

EXPECTED_WORK=false
if [ "$SHOULD" = "work" ]; then
	EXPECTED_WORK=true
fi

# Build dynamic message components
OUTCOME_TEXT="failed"
if [ "$WORKED" = true ]; then
	OUTCOME_TEXT="worked"
fi

EXPECTED_TEXT="Unexpected"
if { [ "$WORKED" = true ] && [ "$EXPECTED_WORK" = true ]; } || { [ "$WORKED" != true ] && [ "$EXPECTED_WORK" != true ]; }; then
	EXPECTED_TEXT="Expected"
fi

RESULT_STATUS="FAIL"
if [ "$EXPECTED_TEXT" = "Expected" ]; then
	RESULT_STATUS="PASS"
fi

echo "$RESULT_STATUS - On: $HOST_IP ; Target: $TARGET_IP on $PORT - $EXPECTED_TEXT $OUTCOME_TEXT"
