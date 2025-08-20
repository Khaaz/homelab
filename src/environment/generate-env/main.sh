#!/bin/bash

# --- Init & Imports ---
get_script_dir() {
  local script_dir
  script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Import strip_comment function
. "$SCRIPT_DIR/../lib/strip_comment.sh"

# Import subfunctions
. "$SCRIPT_DIR/config_parser.sh"
. "$SCRIPT_DIR/template_parser.sh"

# --- Variables ---
GLOBAL_CONFIG_FILE="${SCRIPT_DIR}/../../../config/global-config.toml"
APPS_PATH="${SCRIPT_DIR}/../../../apps"

declare -A global_config

# --- 1: Parse global config ---
echo "LOG: Load config-global.toml: $GLOBAL_CONFIG_FILE"
parse_global_config "$GLOBAL_CONFIG_FILE" global_config
echo "LOG: Loaded config-global.toml"

echo "DEBUG: global_config >"
for k in "${!global_config[@]}"; do
    echo "DEBUG: $k = ${global_config[$k]}"
done
echo "DEBUG: global_config <"

# --- 2: Process each app template ---
echo "LOG: Generating .env for each app stack in $APPS_PATH/*"
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
    process_app_template "$app" "$app_path" global_config
    echo "INFO: Generated .env for $app"
done

PRESEED_PATH="${SCRIPT_DIR}/../../../preseed"
echo "LOG: Generating .env for infrastructure (preseed and IaC)"

echo "INFO: ==> Processing preseed conf: $PRESEED_PATH <=="
process_app_template "preseed" "$PRESEED_PATH" global_config
echo "INFO: Generated .env for preseed"
