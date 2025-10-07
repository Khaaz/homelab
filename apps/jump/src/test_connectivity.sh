#!/bin/sh

## Usage
usage() {
	echo "Usage: $0 --for <host_ip> --target <target_ip> --on <port> --should <work|fail>"
	echo "  Tests TCP connectivity from <host_ip> to <target_ip>:<port> over SSH."
	exit 1
}

## Input verification
HOST_IP=""
TARGET_IP=""
PORT=""
SHOULD=""

while [ $# -gt 0 ]; do
	case "$1" in
		--for)
			HOST_IP=$2; 
			shift 2 
			;;
		--target)
			TARGET_IP=$2; 
			shift 2 
			;;
		--on)
			PORT=$2; 
			shift 2 
			;;
		--should)
			SHOULD=$2; 
			shift 2 
			;;
		-h|--help)
			usage ;;
		*)
			echo "Unknown argument: $1" >&2; usage ;;
	esac
done

if [ -z "$HOST_IP" ] || [ -z "$TARGET_IP" ] || [ -z "$PORT" ] || [ -z "$SHOULD" ]; then
	usage
fi

if [ "$SHOULD" != "work" ] && [ "$SHOULD" != "fail" ]; then
	exit 2
fi

#
## Core
#

TIMEOUT_SECS=5

# Start remote listener on target in background (kept alive by SSH)
ssh -o BatchMode=yes -o ConnectTimeout=10 admin@"$TARGET_IP" \
	"nc -l -n -v -p \"$PORT\"" >/dev/null 2>&1 &
LISTENER_SSH_PID=$!

# Ensure cleanup of background SSH if we exit early
cleanup() {
	if [ -n "${LISTENER_SSH_PID:-}" ]; then
		kill "$LISTENER_SSH_PID" >/dev/null 2>&1 || true
		wait "$LISTENER_SSH_PID" 2>/dev/null || true
	fi
}
trap cleanup EXIT INT TERM

# Give the listener a brief moment to bind
sleep 0.5

# Execute the active test from host -> target
ssh -o BatchMode=yes -o ConnectTimeout=10 admin@"$HOST_IP" \
	nc -n -v -z -w "$TIMEOUT_SECS" "$TARGET_IP" "$PORT" >/dev/null 2>&1
NC_RC=$?

# Stop the background listener SSH
cleanup
trap - EXIT INT TERM

WORKED=false
if [ "$NC_RC" -eq 0 ]; then
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
