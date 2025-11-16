#!/bin/bash

## Prerequesites
get_script_dir() {
	local script_dir
	script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Import
# (none)

#
## Core
#
# Generate fields in config/global-config.generated.toml from config/global-config.default.toml
# - Replaces function calls like generate_token(N) and generate_password(N) with computed placeholders
#   ("computed_token" and "computed_password" respectively for now)
# - Writes output that matches the input exactly except for replaced values
# - If a previous generated file exists, preserves existing values per [section] and key:
#   for any key present before, keep the old full line; otherwise write the new line

current_section_from_line() {
	local line="$1"
	if [[ "$line" =~ ^[[:space:]]*\[([^\]]+)\] ]]; then
		echo "${BASH_REMATCH[1]}"
	else
		echo ""
	fi
}

key_from_line() {
	local line="$1"
	# Capture key up to the '=' sign, allowing dots, dashes and underscores
	if [[ "$line" =~ ^[[:space:]]*([A-Za-z0-9_.-]+)[[:space:]]*= ]]; then
		echo "${BASH_REMATCH[1]}"
	else
		echo ""
	fi
}

replace_functions_in_line() {
	local line="$1"
	# Replace all occurrences of known functions without altering surrounding spaces/quotes
	line="$(echo "$line" | sed -E 's/generate_token\([0-9]+\)/computed_token/g')"
	line="$(echo "$line" | sed -E 's/generate_password\([0-9]+\)/computed_password/g')"
	echo "$line"
}

build_new_from_input() {
	local input_file="$1"
	local file_generated_base="$2"
	: > "$file_generated_base"
	while IFS= read -r raw_line || [[ -n "$raw_line" ]]; do
		# Remove trailing carriage return if present (CRLF) and preserve formatting
		raw_line="${raw_line%$'\r'}"
		# Preserve line exactly, only replace function occurrences
		local replaced_line
		replaced_line="$(replace_functions_in_line "$raw_line")"
		printf "%s\n" "$replaced_line" >> "$file_generated_base"
	done < "$input_file"
}

index_old_generated() {
	local generated_file="$1"
	# Indirect output: associative array name passed as second argument
	local -n out_map_ref="$2"
	local current_section=""
	while IFS= read -r old_line || [[ -n "$old_line" ]]; do
		old_line="${old_line%$'\r'}"
		local sec="$(current_section_from_line "$old_line")"
		if [[ -n "$sec" ]]; then
			current_section="$sec"
			continue
		fi
		local key="$(key_from_line "$old_line")"
		if [[ -n "$key" ]]; then
			out_map_ref["$current_section::$key"]="$old_line"
		fi
	done < "$generated_file"
}

merge_new_with_old() {
	local file_generated_base="$1"
	local generated_file="$2"
	local file_generated_merged="$3"
	# Indirect input map as associative array
	local -n old_line_by_section_ref="$4"

	: > "$file_generated_merged"
	local current_section=""
	while IFS= read -r new_line || [[ -n "$new_line" ]]; do
		new_line="${new_line%$'\r'}"
		local sec="$(current_section_from_line "$new_line")"
		if [[ -n "$sec" ]]; then
			current_section="$sec"
			printf "%s\n" "$new_line" >> "$file_generated_merged"
			continue
		fi
		local key="$(key_from_line "$new_line")"
		if [[ -n "$key" ]]; then
			local map_key="$current_section::$key"
			if [[ -n "${old_line_by_section_ref[$map_key]+_}" ]]; then
				printf "%s\n" "${old_line_by_section_ref[$map_key]}" >> "$file_generated_merged"
			else
				printf "%s\n" "$new_line" >> "$file_generated_merged"
			fi
		else
			printf "%s\n" "$new_line" >> "$file_generated_merged"
		fi
	done < "$file_generated_base"
}

generate_global_config_generated() {
	local input_file="$1"
	local output_file="$2"

	if [[ ! -f "$input_file" ]]; then
		echo "ERROR: global-config.default.toml not found at $input_file"
		return 1
	fi

	local file_generated_base="$output_file.tmp"

	# Phase 1: Produce the "new" file with function replacements only
	build_new_from_input "$input_file" "$file_generated_base"

	# If no previous generated file, just output the new result
	if [[ ! -f "$output_file" ]]; then
		cp "$file_generated_base" "$output_file"
		echo "LOG: Generated $output_file from default with computed values"
		return 0
	fi

	# Phase 2: Merge with previous generated file, preserving existing values by [section] and key
	declare -A old_line_by_section

	index_old_generated "$output_file" old_line_by_section

	local file_generated_merged="$output_file.swap"

	# Phase 3: Merge
	merge_new_with_old "$file_generated_base" "$output_file" "$file_generated_merged" old_line_by_section

	mv "$file_generated_merged" "$output_file"

	echo "LOG: Updated $output_file with preserved values where applicable"
}
