#!/bin/bash

# Loads config values from toml into an associative array
parse_global_config() {
	local config_file="$1"
	local -n config_values=$2

	local current_section=""

	while IFS= read -r line || [[ -n "$line" ]]; do
		# Remove trailing carriage return if present (CRLF)
		line="${line%$'\r'}"

		line=$(strip_comment "$line") # Remove comments at the end of the line without removing "#" withing variable value
		line="$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"  # Trim
		[[ -z "$line" ]] && continue

		if [[ $line =~ ^\[(.+)\]$ ]]; then
			current_section="${BASH_REMATCH[1]}"
			continue
		fi

		if [[ $line =~ ^([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*\"?([^\"]+)\"?$ ]]; then
			local key="${BASH_REMATCH[1]}"
			local val="${BASH_REMATCH[2]}"
			echo "DEBUG: key: $key, $val"
			local full_key="${current_section}.${key}"
			config_values["$full_key"]="$val"
		fi
	done < "$config_file"
}
