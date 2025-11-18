#!/bin/sh

# Base configuration used by authentication and API calls
API_URL="http://localhost:9000"
ADMIN_USER="admin"
ADMIN_PASS="${PORTAINER_ADMIN_PASSWORD:?err}"

# Prints Portainer API JWT token to stdout
auth() {
	curl -sS -k \
		-H "Content-Type: application/json" \
		-X POST "${API_URL}/api/auth" \
		-d "{\"Username\":\"${ADMIN_USER}\",\"Password\":\"${ADMIN_PASS}\"}" \
	| jq -r '.jwt'
}

