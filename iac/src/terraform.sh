#!/bin/sh

## Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

IAC_FOLDER="$SCRIPT_DIR/.."
TERRAFORM_FOLDER="$IAC_FOLDER/terraform"

## Usage
usage() {
	echo "Usage: $0 [--dev] [--destroy] [--console]"
	exit 1
}

## Input verification
DEV=false
DESTROY=false
CONSOLE=false
while [ $# -gt 0 ]; do
	case "$1" in
		--dev)
			DEV=true
			;;
		--destroy)
			DESTROY=true
			;;
		--console)
			CONSOLE=true
			;;
		--help)
			usage
			;;
	esac
	shift
done

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
ENV_FILE="$IAC_FOLDER/config/.env"
GENERATED_ENV_FILE="$IAC_FOLDER/config/.env.generated"
TERRAFORM_ENV_FILE="$IAC_FOLDER/config/terraform.env"

ENV_LOADED=false
if [ -f "$GENERATED_ENV_FILE" ]; then
	set -a
	. "$GENERATED_ENV_FILE"
	set +a
	ENV_LOADED=true
fi
if [ -f "$ENV_FILE" ]; then
	set -a
	. "$ENV_FILE"
	set +a
	ENV_LOADED=true
fi
if [ "$ENV_LOADED" = false ]; then
	echo "Warning: No env file found: $GENERATED_ENV_FILE or $ENV_FILE"
	exit 1
fi
if [ -f "$TERRAFORM_ENV_FILE" ]; then
	set -a
	. "$TERRAFORM_ENV_FILE"
	set +a
else
	echo "Warning: No terraform.env file found: $TERRAFORM_ENV_FILE"
	exit 1
fi

# Logs and debug mode
export TF_LOG="TRACE" 
export TF_LOG_PATH="$TERRAFORM_FOLDER/logs/terraform.log"

# remap env var:
export TF_VAR_proxmox_api_url=$PROXMOX_API_URL
export TF_VAR_proxmox_terraform_api_token="${TERRAFORM_TOKEN_ID}=${TERRAFORM_TOKEN_SECRET}"
export TF_VAR_proxmox_node=$PROXMOX_NODE
export TF_VAR_proxmox_datastore_id=$PROXMOX_DATASTORE_ID
export TF_VAR_proxmox_vm_template_name=$PROXMOX_VM_TEMPLATE_NAME
export TF_VAR_proxmox_vm_template_id=$PROXMOX_VM_TEMPLATE_ID

if [ "$DEV" = true ]; then
	export TF_VAR_dev_mode="true"
fi

cd $TERRAFORM_FOLDER

terraform init
terraform validate
if [ "$CONSOLE" = true ]; then
	terraform console
elif [ "$DESTROY" = true ]; then
	terraform destroy -auto-approve
else
	terraform plan
	terraform apply -auto-approve
fi
