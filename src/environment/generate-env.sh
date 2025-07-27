#!/bin/bash

# Prerequesites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
DIRNAME=$(get_script_dir)

# Import the dependencies function
. $DIRNAME/lib/strip-comment.sh

## Variables
GLOBAL_CONFIG_FILE="${DIRNAME}/../../config/global-config.toml"
APPS_PATH="${DIRNAME}/../../apps"
APP_CONFIG_FILE="src/config/app-config.template.toml"
ENV_FILE="src/config/.env.test"

declare -A config_values

## 1 - Parse global config file: config/global-config.toml
echo "LOG: Load config-global.toml: $GLOBAL_CONFIG_FILE"
current_section=""
while IFS= read -r line || [[ -n "$line" ]]; do
    line=$(strip_comment "$line") # Remove comments at the end of the line without removing "#" withing variable value
    line="$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"  # Trim

    [[ -z "$line" ]] && continue

    if [[ $line =~ ^\[(.+)\]$ ]]; then
        current_section="${BASH_REMATCH[1]}"
        continue
    fi

    if [[ $line =~ ^([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*\"?([^\"]+)\"?$ ]]; then
        key="${BASH_REMATCH[1]}"
        val="${BASH_REMATCH[2]}"
        full_key="${current_section}.${key}"
        config_values["$full_key"]="$val"
    fi
done < "$GLOBAL_CONFIG_FILE"
echo "LOG: Loaded config-global.toml"

## Debug
echo "DEBUG: config_values >"
for k in "${!config_values[@]}"; do
  echo "DEBUG: $k = ${config_values[$k]}"
done
echo "DEBUG: config_values <"

## 2 - Parse each app's template file: apps/*/src/config/app-config.template.toml
echo "LOG: Generating .env for each app stack in $APPS_PATH/*"
for app_path in $APPS_PATH/*; do
    [ -d "$app_path" ] || continue

    app=$(basename "$app_path")

    # Check if app is enabled
    enabled_key="$app.enabled"
    enabled_value="${config_values[$enabled_key]}"
    if [[ "${enabled_value,,}" == "false" ]]; then
        echo "LOG: Skipping disabled app: $app"
        continue
    fi

    echo "LOG: ==> Processing app: $app <=="

    template_file="$app_path/$APP_CONFIG_FILE"
    output_file="$app_path/$ENV_FILE"

    if [[ ! -f "$template_file" ]]; then
        echo "WARN: No template found for app '$app'. Skipping."
        continue
    fi

    echo "# Auto-generated .env for $app" > "$output_file"

    # Process each line of the app template file
    while IFS= read -r line || [[ -n "$line" ]]; do
        original_line="$line"
        line="$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"  # Trim

        [[ -z "$line" ]] && continue

        # Extract all $key occurrences in the line
        while [[ "$line" =~ (\$\{([A-Za-z0-9_.-]+)\}) ]]; do
            placeholder="${BASH_REMATCH[1]}"
            key="${BASH_REMATCH[2]}"
            echo "DEBUG: key: $key"

            # Extract the value for this $key from the config_values map
            if [[ -n "${config_values[$key]}" ]]; then
                value="${config_values[$key]}"
            elif [[ -n "${config_values[$app.$key]}" ]]; then
                value="${config_values[$app.$key]}"
            elif [[ -n "${config_values[global.$key]}" ]]; then
                value="${config_values[global.$key]}"
            else
                echo "WARN: Missing value for '$key' in $app or global" >&2
                value=""
            fi

            # Escape value for safety (basic)
            value_escaped="${value//\//\\/}"
            line="${line//$placeholder/$value_escaped}"
        done

        echo "$line" >> "$output_file"
    done < "$template_file"

    echo "LOG: Generated .env for $app in $output_file"
done