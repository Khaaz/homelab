#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

#
## Usage
#
usage() {
	echo "Usage: $0 [--auto]"
	echo "--auto mode will use sensible defaults (no-op in this script)"
	exit 1
}

#
## Input verification
#
AUTO=false
while [ $# -gt 0 ]; do
	case "$1" in
		--auto)
			AUTO=true
			shift
			;;
		--help)
			usage
			;;
		*)
			shift
			;;
	esac
done

# --auto is intentionally a no-op in this script to keep behavior unchanged
if [ "$AUTO" = true ]; then
	echo "INFO: Executing in AUTO mode (infra ready)"
fi

#
## Core
#

# Load global config once
CONFIG_FILE="$SCRIPT_DIR/../config/global-config.toml"
if [ ! -f "$CONFIG_FILE" ]; then
	echo "Error: Global config file not found: $CONFIG_FILE"
	exit 1
fi
CONFIG_CONTENT=$(cat "$CONFIG_FILE")

# Initialize summary lists
INSTALLED_VMS=""
SKIPPED_VMS=""

## Check if VM is enabled in global config
is_vm_enabled() {
	local vm_name="$1"

	# Parse the preloaded config content once, robust to spaces/tabs/newlines and key order
	# - Match section header [vm_name]
	# - Within the section, find the last occurrence of enabled= and normalize whitespace
	# - Ignore comments starting with #
	printf "%s" "$CONFIG_CONTENT" | awk -v section="$vm_name" '
		BEGIN { in_section = 0; enabled = "" }
		{
			line = $0
			header = line
			sub(/#.*/, "", header)                # strip comments for header detection
		}
		# any new section ends current
		header ~ /^[[:space:]]*\[/ { in_section = 0 }
		# match exact section header after removing comments and surrounding whitespace
		header ~ "^[[:space:]]*\\[" section "\\][[:space:]]*$" { in_section = 1; next }
		in_section {
			work = line
			sub(/#.*/, "", work)                 # strip comments
			gsub(/[[:space:]]/, "", work)        # remove all whitespace
			if (work ~ /^enabled=/) {
				split(work, a, "=")
				enabled = a[2]
			}
		}
		END {
			if (enabled == "true") exit 0; else exit 1
		}
	'
}

## Setup VM if enabled
setup_vm_if_enabled() {
	local vm_name="$1"
	if is_vm_enabled "$vm_name"; then
		echo "Setting up $vm_name (enabled in config)..."
		$SCRIPT_DIR/4-2.setup_vm.sh --auto --skip-jump "$vm_name"
		# Add to installed list
		if [ -z "$INSTALLED_VMS" ]; then
			INSTALLED_VMS="$vm_name"
		else
			INSTALLED_VMS="$INSTALLED_VMS, $vm_name"
		fi
	else
		echo "Skipping $vm_name (disabled in config)..."
		# Add to skipped list
		if [ -z "$SKIPPED_VMS" ]; then
			SKIPPED_VMS="$vm_name"
		else
			SKIPPED_VMS="$SKIPPED_VMS, $vm_name"
		fi
	fi
}

echo "Checking global-config.toml for enabled VMs..."

# Core infrastructure VMs (besides firewalls / routers) (must be set up first)
setup_vm_if_enabled "dns"
setup_vm_if_enabled "reverse-proxy"
# setup_vm_if_enabled "nas" # no need to setup NAS vm: simple nfs server (no software) for now
setup_vm_if_enabled "management"
setup_vm_if_enabled "vpn"

# Application VMs
setup_vm_if_enabled "cloud"
setup_vm_if_enabled "home-automation"
setup_vm_if_enabled "immich"
setup_vm_if_enabled "media-management"
setup_vm_if_enabled "media-server"
setup_vm_if_enabled "notes"
setup_vm_if_enabled "sandbox"
setup_vm_if_enabled "vault"
setup_vm_if_enabled "vscode-server"
setup_vm_if_enabled "whiteboard"

echo "VMs setup complete!"

# Summary of VMs
echo ""
echo "=== VM Setup Summary ==="
if [ -n "$INSTALLED_VMS" ]; then
	echo "Installed VMs: $INSTALLED_VMS"
else
	echo "Installed VMs: none"
fi

if [ -n "$SKIPPED_VMS" ]; then
	echo "Skipped VMs: $SKIPPED_VMS"
else
	echo "Skipped VMs: none"
fi
