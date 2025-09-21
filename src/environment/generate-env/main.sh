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
. "$SCRIPT_DIR/config_parser.sh"
. "$SCRIPT_DIR/template_parser.sh"

GLOBAL_CONFIG_FILE="${SCRIPT_DIR}/../../../config/global-config.toml"
APPS_PATH="${SCRIPT_DIR}/../../../apps"

declare -A global_config

#
## Core
#
# --- 1: Parse global config ---
echo "LOG: Load config-global.toml: $GLOBAL_CONFIG_FILE"
parse_global_config "$GLOBAL_CONFIG_FILE" global_config
echo "LOG: Loaded config-global.toml"

echo "DEBUG: global_config >"
for k in "${!global_config[@]}"; do
	echo "DEBUG: $k = ${global_config[$k]}"
done
echo "DEBUG: global_config <"

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
PRESEED_PATH="${SCRIPT_DIR}/../../../preseed"
IAC_PATH="${SCRIPT_DIR}/../../../iac"

echo "LOG: Generating config/.env.generated for infrastructure (preseed and IaC)"

echo "INFO: ==> Processing preseed conf: $PRESEED_PATH <=="
process_app_template "preseed" "$PRESEED_PATH/$CONFIG_INPUT_FILE" "$PRESEED_PATH/$CONFIG_OUTPUT_FILE" global_config
echo "INFO: Generated config/.env for preseed"

echo "INFO: ==> Processing iac conf: $IAC_PATH <=="
process_app_template "iac" "$IAC_PATH/$CONFIG_INPUT_FILE" "$IAC_PATH/$CONFIG_OUTPUT_FILE" global_config
echo "INFO: Generated config/.env for iac"
