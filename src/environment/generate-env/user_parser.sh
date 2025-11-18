#!/bin/bash

# Parses users-config.toml to extract users config (for SSO Provider and admin auth). 
# Outputs:
# - admin password
# - USERS as JSON array of user objects:
#   [{"name":"user","password":"password","group":"family"}, ...]

strip_surrounding_quotes() {
	local val="$1"
	val="$(echo "$val" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"
	if [[ ${#val} -ge 2 ]]; then
		local first_char="${val:0:1}"
		local last_char="${val: -1}"
		if [[ ( "$first_char" == "\"" && "$last_char" == "\"" ) || ( "$first_char" == "'" && "$last_char" == "'" ) ]]; then
			val="${val:1:${#val}-2}"
		fi
	fi
	echo "$val"
}

push_unique_section() {
	local -n order_ref=$1
	local name="$2"
	local exists=0
	for s in "${order_ref[@]}"; do
		if [[ "$s" == "$name" ]]; then
			exists=1
			break
		fi
	done
	if [[ $exists -eq 0 ]]; then
		order_ref+=("$name")
	fi
}

json_escape() {
	local s="$1"
	s="${s//\\/\\\\}"
	s="${s//\"/\\\"}"
	s="${s//$'\n'/\\n}"
	s="${s//$'\t'/\\t}"
	echo "$s"
}

# Build JSON
build_users_json() {
	local -n order_ref=$1
	local -n group_ref=$2
	local -n pass_ref=$3
	local -n out_ref=$4

	local json="["
	local first=1
	for user in "${order_ref[@]}"; do
		local group="${group_ref[$user]}"
		local password="${pass_ref[$user]}"
		if [[ -z "$group" || -z "$password" ]]; then
			echo "WARN: Skipping user '$user' due to missing GROUP or PASSWORD"
			continue
		fi
		local name_esc="$(json_escape "$user")"
		local group_esc="$(json_escape "$group")"
		local password_esc="$(json_escape "$password")"
		if [[ $first -eq 1 ]]; then
			first=0
		else
			json+=","
		fi
		json+="{\"name\":\"$name_esc\",\"password\":\"$password_esc\",\"group\":\"$group_esc\"}"
	done
	json+="]"
	out_ref="$json"
}

# Main
# Parse users-config.toml and output admin password and USERS as JSON object
# - admin password
# - USERS as JSON array of user objects:
#   [{"name":"user","password":"password","group":"family"}, ...]
parse_users_config() {
	local config_file="$1"
	local -n admin_password_out=$2
	local -n users_out=$3

	if [[ ! -f "$config_file" ]]; then
		echo "WARN: users-config.toml not found at $config_file"
		return 0
	fi

	local current_section=""
	declare -A section_group
	declare -A section_password
	declare -a section_order=()

	while IFS= read -r line || [[ -n "$line" ]]; do
		# Remove trailing carriage return if present (CRLF)
		line="${line%$'\r'}"

		line="$(strip_comment "$line")"
		line="$(echo "$line" | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')"  # Trim
		[[ -z "$line" ]] && continue

		# Section header
		if [[ $line =~ ^\[(.+)\]$ ]]; then
			current_section="${BASH_REMATCH[1]}"
			continue
		fi

		# key=value (value possibly quoted with " or ')
		if [[ $line =~ ^([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*(.+)$ ]]; then
			local key="${BASH_REMATCH[1]}"
			local val="${BASH_REMATCH[2]}"
			val="$(strip_surrounding_quotes "$val")"

			# admin section
			if [[ "$current_section" == "admin" && "$key" == "ADMIN_PASSWORD" ]]; then
				admin_password_out="$val"
				continue
			fi

			# user sections
			if [[ -n "$current_section" && "$current_section" != "admin" ]]; then
				push_unique_section section_order "$current_section"
				if [[ "$key" == "GROUP" ]]; then
					section_group["$current_section"]="$val"
				elif [[ "$key" == "PASSWORD" ]]; then
					section_password["$current_section"]="$val"
				fi
			fi
		fi
	done < "$config_file"

	# Build USERS JSON array
	build_users_json section_order section_group section_password users_out
}


