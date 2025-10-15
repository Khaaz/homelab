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
    echo "Usage: $0 [--refresh-config <none|generated|full>] <vm>"
    echo
    echo "Options:"
    echo "  --refresh-config, -rc  Set config refresh level (default: full)"
    echo "    - none      : do nothing"
    echo "    - generated : copy .env.generated"
    echo "    - full      : also copy .env and networking.env from controller root (override if present)"
    exit 1
}

## Input verification
REFRESH_CONFIG="full"
VM_NAME=""
while [ $# -gt 0 ]; do
    case "$1" in
        --refresh-config|-rc)
            REFRESH_CONFIG=$2
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            VM_NAME="$1"
            shift
            ;;
    esac
done

if [ -z  "$VM_NAME" ]; then
    usage
fi

#
## Core
#
TARGET_IP=$("$SCRIPT_DIR/src/get_vm_ip.sh" "$VM_NAME")
SSH_KEY=$ROOT_DIR/config/ssh/$VM_NAME/automation_key

$ROOT_DIR/iac/5.setup_vm.sh setup --app "$VM_NAME" --ip "$TARGET_IP" --key "$SSH_KEY" --refresh-config "$REFRESH_CONFIG"
