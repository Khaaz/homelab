#!/bin/sh

## Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
usage() {
	echo "Usage: $0 <app|vm> [--root] [--reset]"
	exit 1
}

# Input verification
if [ -z "$1" ]; then
	usage
fi
APP="$1"
shift

GENERATE_ROOT=false
RESET_KEYS=false
while [ $# -gt 0 ]; do
	case "$1" in
		--root)
			GENERATE_ROOT=true
			;;
		--reset)
            RESET_KEYS=true
            ;;
		*)
			echo "Unknown argument: $1"
			usage
			;;
	esac
	shift
done

ROOT_DIR="$SCRIPT_DIR/../../.."
CONFIG_DIR="$ROOT_DIR/config"
SSH_DIR="$CONFIG_DIR/ssh/$APP"

#
## Core
#
# Create SSH directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
	echo "LOG: Creating SSH directory: $SSH_DIR"
	mkdir -p "$SSH_DIR"
fi

generate_key() {
    local user=$1
    local file="$SSH_DIR/${user}_key"

    if [ -f "$file" ] && [ "$RESET_KEYS" = false ]; then
        echo "WARN: Key for user '$user' already exists, skipping (use --reset to regenerate)."
        return
    fi

    if [ -f "$file" ] && [ "$RESET_KEYS" = true ]; then
        echo "LOG: Resetting key for user '$user'..."
        rm -f "$file" "$file.pub"
    fi

    echo "LOG: Generating SSH key for user: $user"
    "$SCRIPT_DIR/../../utils/ssh_keygen.sh" -C "${user}@homelab" -f "$file"
}

# Execute ssh_keygen function
echo "INFO: Generating SSH keys for app: $APP"

echo "INFO: Generating user: admin"
generate_key "admin"
echo "INFO: Generating user: automation"
generate_key "automation"

if [ "$GENERATE_ROOT" = true ]; then
	echo "INFO: Generating user: root"
	generate_key "root"
fi

chmod 600 "$SSH_DIR/"*_key
