#!/bin/sh

# Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Usage
if [ -z "$1" ]; then
	echo "Usage: $0 <user>"
	exit 1
fi

USER="$1"

ROOT_DIR="$SCRIPT_DIR/../../.."
CONFIG_DIR="$ROOT_DIR/config"
SSH_DIR="$CONFIG_DIR/ssh/$USER"

# Create SSH directory if it doesn't exist
if [ ! -d "$SSH_DIR" ]; then
	echo "Creating SSH directory: $SSH_DIR"
	mkdir -p "$SSH_DIR"
fi

# Execute ssh_keygen function
echo "Generating SSH keys for user: $USER"
$SCRIPT_DIR/../../utils/ssh_keygen.sh -C "$USER@homelab" -f "$SSH_DIR/${USER}_key"
