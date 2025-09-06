#!/bin/bash
# Processes app config templates into .env.generated files using config_values

## Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Core
APP_CONFIG_FILE="config/app-config.template.toml"
ENV_FILE="config/.env.generated"

# Replace all ${key} placeholders in a line using config values
replace_placeholders() {
	local app="$1"
	local -n current_line="$2"
	local -n config_values=$3

	while [[ "$current_line" =~ (\$\{([A-Za-z0-9_.-]+)\}) ]]; do
		local placeholder="${BASH_REMATCH[1]}"
		local key="${BASH_REMATCH[2]}"

		echo "DEBUG: key: $key"

		local value=""
		# Extract the value for this $key from the config_values map
		if [[ -n "${config_values[$key]}" ]]; then
			value="${config_values[$key]}"
		elif [[ -n "${config_values[$app.$key]}" ]]; then
			value="${config_values[$app.$key]}"
		elif [[ -n "${config_values[global.$key]}" ]]; then
			value="${config_values[global.$key]}"
		else
			echo "WARN: Missing value for '$key' in $app or global" >&2
		fi

		# Escape slashes for safe replacement
		# local value_escaped="${value//\//\\/}"
		current_line="${current_line//$placeholder/$value}"
	done
}

# Detect and replace password() calls in the line
replace_password_functions() {
	local -n current_line="$1"

	# password_sha512()
	if [[ "$current_line" =~ password_sha512\(\$?\{?([^\)]*)\}?\) ]]; then
		local password_value="${BASH_REMATCH[1]}"

		local hashed_password=$("$SCRIPT_DIR/../../utils/encrypt_sha512.sh" "$password_value")

		local hashed_password_escaped="${hashed_password//\//\\/}"
		current_line="$(echo "$current_line" | sed "s|password_sha512($password_value)|$hashed_password_escaped|")"
	# password_argon()
	elif [[ "$current_line" =~ password_argon\(\$?\{?([^\)]*)\}?\) ]]; then
		local password_value="${BASH_REMATCH[1]}"

		local hashed_password=$("$SCRIPT_DIR/../../utils/encrypt_argon.sh" "$password_value")

		local hashed_password_escaped="${hashed_password//\//\\/}"
		current_line="$(echo "$current_line" | sed "s|password_argon($password_value)|$hashed_password_escaped|")"
	fi
}

# Main function: process a single app template file
process_app_template() {
	local app="$1"
	local app_path="$2"
	local -n global_config_values=$3

	local template_file="$app_path/$APP_CONFIG_FILE"
	local output_file="$app_path/$ENV_FILE"

	if [[ ! -f "$template_file" ]]; then
		echo "WARN: No template found for app '$app'. Skipping."
		return
	fi

	echo "DEBUG: $template_file > $output_file"

	echo "# Auto-generated .env for $app" > "$output_file"

	while IFS= read -r line || [[ -n "$line" ]]; do
		# Remove trailing carriage return if present (CRLF)
		line="${line%$'\r'}"

		line="$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"  # Trim
		[[ -z "$line" ]] && continue

		# Replace placeholders
		replace_placeholders "$app" line global_config_values

		# Replace password() functions
		replace_password_functions line

		echo "$line" >> "$output_file"
	done < "$template_file"
}
