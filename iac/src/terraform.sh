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

#
## Core
#
# Source environment variables from 
# config/.env (standard env file)
# config/.env.generated (generated env file)
ENV_FILE="$IAC_FOLDER/config/.env"
GENERATED_ENV_FILE="$IAC_FOLDER/config/.env.generated"

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

# Logs and debug mode
export TF_LOG="TRACE" 
export TF_LOG_PATH="$TERRAFORM_FOLDER/logs/terraform.log"

cd $TERRAFORM_FOLDER
# terraform destroy -auto-approve
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
