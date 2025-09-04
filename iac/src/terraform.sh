#!/bin/sh

# Prerequisites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Core
# Source environment variables from ./config/.env (standard env file)
ENV_FILE="$SCRIPT_DIR/config/.env"
if [ -f "$ENV_FILE" ]; then
	set -a
	. "$ENV_FILE"
	set +a
else
  	echo "Warning: Env file not found: $ENV_FILE"
fi

TERRAFORM_FOLDER="$SCRIPT_DIR/../terraform"

cd $TERRAFORM_FOLDER
# terraform destroy -auto-approve
terraform init
terraform validate
terraform plan -out=tfplan
terraform apply -auto-approve tfplan
