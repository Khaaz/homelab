#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Source auth function
. "$SCRIPT_DIR/auth.sh"

#
## Core
#

# create_group <group_name>
# Creates an endpoint group if it doesn't exist and prints its ID
create_group() {
	local group_name="$1"
	local existing_id

	existing_id="$(curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		"${API_URL}/api/endpoint_groups" \
	| jq -r --arg n "${group_name}" '.[] | select(.Name == $n) | .Id' | head -n1)"

	if [ -n "${existing_id}" ]; then
		echo "${existing_id}"
		return 0
	fi

	curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		-H "Content-Type: application/json" \
		-X POST "${API_URL}/api/endpoint_groups" \
		-d "{\"Name\":\"${group_name}\"}" \
	| jq -r '.Id'
}

# assign_team_access_to_group <group_name> <group_id> <team_name>
# Adds/updates TeamAccessPolicies for the given team on the endpoint group
assign_team_access_to_group() {
	local group_name="$1"
	local group_id="$2"
	local team_name="$3"
	local role_id="4"

	echo "Assigning team access to group: ${group_name}"

	# Fetch team ID by name	
	local team_id
	team_id="$(curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		"${API_URL}/api/teams" \
	| jq -r --arg n "${team_name}" '.[] | select(.Name == $n) | .Id' | head -n1)"

	[ -z "${team_id}" ] && echo "Team not found: ${team_name}" && return 1

	# Prepare payload to OVERRIDE policies (only one team policy, empty user policies)
	local payload http_code
	payload="$(jq -n \
		--arg name "${group_name}" \
		--arg tid "$(printf '%s' "${team_id}")" \
		--argjson rid "${role_id}" \
		'{Name: $name, TeamAccessPolicies: {($tid): {RoleId: $rid}}, UserAccessPolicies: {}}')"

	# Update group
	http_code="$(curl -sS -k -o /dev/null -w "%{http_code}" \
		-H "Authorization: Bearer ${TOKEN}" \
		-H "Content-Type: application/json" \
		-X PUT "${API_URL}/api/endpoint_groups/${group_id}" \
		-d "${payload}")"

	if [ "${http_code}" -ge 200 ] && [ "${http_code}" -lt 300 ]; then
		echo "Assigning team access: success"
	else
		echo "Assigning team access: fail"
		return 1
	fi
}

# create_endpoint_in_environment <name> <ip>
# Creates an agent (non-edge) Docker endpoint at tcp://<ip>:19001 in the given endpoint group
create_endpoint_in_environment() {
	local name="$1"
	local ip="$2"
	local url="tcp://${ip}:19001"
	local http_code

	echo "Creating endpoint: ${name}"
	
	http_code="$(curl -sS -k -o /dev/null -w "%{http_code}" \
		-H "Authorization: Bearer ${TOKEN}" \
		-X POST "${API_URL}/api/endpoints?endpointType=2" \
		-F "Name=${name}" \
		-F "URL=${url}" \
		-F "GroupID=${GROUP_ID}" \
		-F "EndpointCreationType=2" \
		-F "ContainerEngine=docker" \
		-F "TLS=true" \
		-F "TLSSkipVerify=true" \
		-F "TLSSkipClientVerify=true")"

	if [ "${http_code}" -ge 200 ] && [ "${http_code}" -lt 300 ]; then
		echo "Endpoint creation: success"
	else
		echo "Endpoint creation: fail"
		return 1
	fi
}

# remove_all_endpoints
# Deletes all existing endpoints
remove_all_endpoints() {
	local ids

	echo "Removing all existing endpoints"
	
	ids="$(curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		"${API_URL}/api/endpoints" \
	| jq -r '.[].Id')"

	[ -z "${ids}" ] && return 0

	for id in ${ids}; do
		echo "Removing endpoint: ${id}"
		curl -sS -k \
			-H "Authorization: Bearer ${TOKEN}" \
			-X DELETE "${API_URL}/api/endpoints/${id}" \
		> /dev/null
	done
}

## Main

# - generate the token
TOKEN="$(auth)"

# - create group "homelab" if it doesn't exist
echo "Creating group: homelab"
GROUP_ID="$(create_group "homelab")"

# - assign team access for 'admin' team to the group
assign_team_access_to_group "homelab" "${GROUP_ID}" "admin"

# - initialise endpoints
echo "Initialising endpoints"
remove_all_endpoints
# create_endpoint_in_environment "cloud" "${CLD_IP}"
create_endpoint_in_environment "dns" "${DNS_IP}"
# create_endpoint_in_environment "home-automation" "${HA_IP}"
# create_endpoint_in_environment "immich" "${IM_IP}"
create_endpoint_in_environment "media-management" "${MM_IP}"
create_endpoint_in_environment "media-server" "${MS_IP}"
# create_endpoint_in_environment "notes" "${NTS_IP}"
create_endpoint_in_environment "reverse-proxy" "${RP_IP}"
create_endpoint_in_environment "sandbox" "${SBX_IP}"
# create_endpoint_in_environment "vault" "${VLT_IP}"
create_endpoint_in_environment "vpn" "${VPN_IP}"
# create_endpoint_in_environment "vscode-server" "${VSC_IP}"
# create_endpoint_in_environment "whiteboard" "${WB_IP}"
