#!/bin/bash

## Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Import
# Import strip_comment function
. "$SCRIPT_DIR/../lib/strip_comment.sh"

# Import subfunctions
. "$SCRIPT_DIR/prepare_config.sh"
. "$SCRIPT_DIR/user_parser.sh"
. "$SCRIPT_DIR/config_parser.sh"
. "$SCRIPT_DIR/template_parser.sh"

GLOBAL_CONFIG_FILE="${SCRIPT_DIR}/../../../config/global-config.toml"
GLOBAL_CONFIG_DEFAULT_FILE="${SCRIPT_DIR}/../../../config/global-config.default.toml"
GLOBAL_CONFIG_GENERATED_FILE="${SCRIPT_DIR}/../../../config/global-config.generated.toml"
USERS_CONFIG_FILE="${SCRIPT_DIR}/../../../config/users-config.toml"
APPS_PATH="${SCRIPT_DIR}/../../../apps"

declare -A global_config
declare users_admin_password=""
declare users_entries=""

## Input verification
if [ ! -f "$GLOBAL_CONFIG_FILE" ]; then
	echo "ERROR: global-config.toml not found at $GLOBAL_CONFIG_FILE"
	exit 1
fi

#
## Core
#

# --- 0: Generate global-config.generated.toml ---
echo "LOG: Generating global-config.generated.toml from global-config.default.toml"
generate_global_config_generated "$GLOBAL_CONFIG_DEFAULT_FILE" "$GLOBAL_CONFIG_GENERATED_FILE"
echo "LOG: Generated global-config.generated.toml"

# --- 1a: Parse global-config.generated ---
echo "LOG: Load global-config.generated.toml: $GLOBAL_CONFIG_GENERATED_FILE"
parse_global_config "$GLOBAL_CONFIG_GENERATED_FILE" global_config
echo "LOG: Loaded global-config.generated.toml"

# --- 1b: Parse global config (will override generated values) ---
echo "LOG: Load config-global.toml: $GLOBAL_CONFIG_FILE"
parse_global_config "$GLOBAL_CONFIG_FILE" global_config
echo "LOG: Loaded config-global.toml"

# --- 1c: Parse users-config.toml if present ---
if [ -f "$USERS_CONFIG_FILE" ]; then
	echo "LOG: Load users-config.toml: $USERS_CONFIG_FILE"
	parse_users_config "$USERS_CONFIG_FILE" users_admin_password users_entries
	echo "LOG: Loaded users-config.toml"
else
	echo "LOG: users-config.toml not found, skipping users override"
fi

# --- 1d: Override users section from users-config.toml if present ---
if [ -n "$users_admin_password" ]; then
	echo "LOG: Overriding [users.ADMIN_PASSWORD] section from users-config.toml"
	global_config["users.ADMIN_PASSWORD"]="$users_admin_password"
fi
if [ -n "$users_entries" ]; then
	echo "LOG: Overriding [users.USERS] section from users-config.toml"
	global_config["users.USERS"]="$users_entries"
fi

echo "LOG: Ensure global_config is valid >>>"
not_implemented_found="false"
for key in "${!global_config[@]}"; do
	section="${key%%.*}"
	section_enabled_key="${section}.enabled"
	
	section_enabled="${global_config[$section_enabled_key]}"
	current_value="${global_config[$key]}"
	
	if [ -n "$DEBUG" ]; then
		echo "DEBUG (main): $key = $current_value"
	fi
	
	# Verification: flag not_implemented() when the section is not explicitly disabled
	if [[ "$current_value" == "not_implemented()" && "${section_enabled,,}" != "false" ]]; then
		echo "ERROR: Not implemented value for enabled section: $key"
		not_implemented_found="true"
	fi
done
echo "LOG: Ensure global_config is valid <<<"

if [[ "$not_implemented_found" == "true" ]]; then
	echo "ERROR: One or more required config values are not implemented for enabled sections."
	exit 1
fi

# --- 2: Generate config/.env.generated ---
CONFIG_INPUT_FILE="config/app-config.template.toml"
CONFIG_OUTPUT_FILE="config/.env.generated"
INFRA_INPUT_FILE="infra/app-infra.template.toml"
INFRA_OUTPUT_FILE="infra/local.env.generated"

echo "LOG: Generating config/.env.generated for each app stack in $APPS_PATH/*"
for app_path in $APPS_PATH/*; do
	[ -d "$app_path" ] || continue
	app=$(basename "$app_path")

	# Enabled check
	enabled_key="$app.enabled"
	enabled_value="${global_config[$enabled_key]}"
	if [[ "${enabled_value,,}" == "false" ]]; then
		echo "LOG: Skipping disabled app: $app"
		continue
	fi

	echo "INFO: ==> Processing app: $app <=="
	process_app_template "$app" "$app_path/$CONFIG_INPUT_FILE" "$app_path/$CONFIG_OUTPUT_FILE" global_config
	echo "INFO: Generated config/.env for $app"
done

# --- 3: Generate infra/local.env.generated ---
echo "LOG: Generating infra/local.env.generated for each app stack in $APPS_PATH/*"
for app_path in $APPS_PATH/*; do
	[ -d "$app_path" ] || continue
	app=$(basename "$app_path")

	# Enabled check
	enabled_key="$app.enabled"
	enabled_value="${global_config[$enabled_key]}"
	if [[ "${enabled_value,,}" == "false" ]]; then
		echo "LOG: Skipping disabled app: $app"
		continue
	fi

	echo "INFO: ==> Processing app: $app <=="
	process_app_template "$app" "$app_path/$INFRA_INPUT_FILE" "$app_path/$INFRA_OUTPUT_FILE" global_config
	echo "INFO: Generated infra/local.env for $app"
done

# --- 4: Generate config/.env.generated for IAC and preseed  ---
ENVIRONMENT_PATH="${SCRIPT_DIR}/../../../environment"

echo "LOG: Generating config/.env.generated for environment"

echo "INFO: ==> Processing environment conf: $ENVIRONMENT_PATH <=="
process_app_template "environment" "$ENVIRONMENT_PATH/$CONFIG_INPUT_FILE" "$ENVIRONMENT_PATH/$CONFIG_OUTPUT_FILE" global_config
echo "INFO: Generated config/.env for environment"

# --- 5: Generate config/.env.generated for IAC and preseed  ---
PRESEED_PATH="${SCRIPT_DIR}/../../../preseed"
IAC_PATH="${SCRIPT_DIR}/../../../iac"

echo "LOG: Generating config/.env.generated for infrastructure (preseed and IaC)"

echo "INFO: ==> Processing preseed conf: $PRESEED_PATH <=="
process_app_template "preseed" "$PRESEED_PATH/$CONFIG_INPUT_FILE" "$PRESEED_PATH/$CONFIG_OUTPUT_FILE" global_config
echo "INFO: Generated config/.env for preseed"

echo "INFO: ==> Processing iac conf: $IAC_PATH <=="
process_app_template "iac" "$IAC_PATH/$CONFIG_INPUT_FILE" "$IAC_PATH/$CONFIG_OUTPUT_FILE" global_config
echo "INFO: Generated config/.env for iac"
