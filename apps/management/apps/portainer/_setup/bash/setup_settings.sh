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

# create_team <team_name>
# Creates a team if it doesn't exist and prints its ID
create_team() {
	local team_name="$1"
	local existing_id

	existing_id="$(curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		"${API_URL}/api/teams" \
	| jq -r --arg n "${team_name}" '.[] | select(.Name == $n) | .Id' | head -n1)"

	if [ -n "${existing_id}" ]; then
		echo "${existing_id}"
		return 0
	fi

	curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		-H "Content-Type: application/json" \
		-X POST "${API_URL}/api/teams" \
		-d "{\"Name\":\"${team_name}\"}" \
	| jq -r '.Id'
}

# update_settings_oauth
# Enables OAuth auth method
update_settings_oauth() {
	local current
	current="$(curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		"${API_URL}/api/settings")"

	echo "${current}" \
	| jq \
		--arg cid "portainer" \
		--arg csec "${PORTAINER_OIDC_CLIENT_SECRET:?err}" \
		--arg auth "https://auth.${INTERNAL_DOMAIN:?err}/api/oidc/authorization" \
		--arg token "https://auth.${INTERNAL_DOMAIN:?err}:5000/api/oidc/token" \
		--arg userinfo "https://auth.${INTERNAL_DOMAIN:?err}:5000/api/oidc/userinfo" \
		--arg redirect "https://portainer.${INTERNAL_DOMAIN:?err}" \
		--arg uid "preferred_username" \
		--arg scopes "openid email groups profile" \
		--argjson authstyle 1 \
		--argjson sso true \
		--argjson autocreate true \
		--argjson defteam ${TEAM_ID} \
		--argjson kube '[]' \
		' .AuthenticationMethod = 3
		| .UserSessionTimeout = "720h"
		| .OAuthSettings.ClientID = $cid
		| .OAuthSettings.ClientSecret = $csec
		| .OAuthSettings.AuthorizationURI = $auth
		| .OAuthSettings.AccessTokenURI = $token
		| .OAuthSettings.ResourceURI = $userinfo
		| .OAuthSettings.RedirectURI = $redirect
		| .OAuthSettings.UserIdentifier = $uid
		| .OAuthSettings.Scopes = $scopes
		| .OAuthSettings.AuthStyle = $authstyle
		| .OAuthSettings.SSO = $sso
		| .OAuthSettings.OAuthAutoCreateUsers = $autocreate
		| .OAuthSettings.DefaultTeamID = $defteam
		| .OAuthSettings.KubeSecretKey = $kube
		' \
	| curl -sS -k \
		-H "Authorization: Bearer ${TOKEN}" \
		-H "Content-Type: application/json" \
		-X PUT "${API_URL}/api/settings" \
		-d @- > /dev/null
}

## Main

# - generate the token
TOKEN="$(auth)"

# - create team "admin" if it doesn't exist
echo "Creating team: admin"
TEAM_ID="$(create_team "admin")"

# # - update settings to enable Oauth
update_settings_oauth
