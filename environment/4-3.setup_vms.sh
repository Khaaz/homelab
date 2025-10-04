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
	echo "Usage: $0"
	echo "Setup all enabled VMs from global-config.toml"
	exit 1
}

## Check if VM is enabled in global config
is_vm_enabled() {
	local vm_name="$1"
	local config_file="$SCRIPT_DIR/../config/global-config.toml"
	
	if [ ! -f "$config_file" ]; then
		echo "Error: Global config file not found: $config_file"
		return 1
	fi
	
	# Extract the enabled value for the VM section
	local enabled_value=$(grep -A 1 "^\[$vm_name\]" "$config_file" | grep "enabled=" | cut -d'=' -f2 | tr -d ' "')
	
	if [ "$enabled_value" = "true" ]; then
		return 0  # enabled
	else
		return 1  # disabled or not found
	fi
}

## Setup VM if enabled
setup_vm_if_enabled() {
	local vm_name="$1"
	
	if is_vm_enabled "$vm_name"; then
		echo "Setting up $vm_name (enabled in config)..."
		$SCRIPT_DIR/4-2.setup_vm.sh "$vm_name"
	else
		echo "Skipping $vm_name (disabled in config)..."
	fi
}

#
## Core - Setup all enabled VMs in order
#

echo "Checking global-config.toml for enabled VMs..."

# Core infrastructure VMs (must be set up first)
setup_vm_if_enabled "dns"
setup_vm_if_enabled "reverse-proxy"
setup_vm_if_enabled "vpn"

# Application VMs
setup_vm_if_enabled "home-automation"
setup_vm_if_enabled "media-management"
setup_vm_if_enabled "media-server"
setup_vm_if_enabled "nas"
setup_vm_if_enabled "notes"
setup_vm_if_enabled "sandbox"
setup_vm_if_enabled "todo"
setup_vm_if_enabled "vault"
setup_vm_if_enabled "vscode-server"
setup_vm_if_enabled "white-board"

echo "VM setup complete!"
