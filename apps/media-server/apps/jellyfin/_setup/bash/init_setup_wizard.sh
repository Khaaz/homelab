#!/bin/bash
set -euo pipefail

## Configuration
JELLYFIN_URL="http://127.0.0.1:8096"
JELLYFIN_USER="${JELLYFIN_ADMIN_USER:-admin}"
JELLYFIN_PASSWORD="${JELLYFIN_ADMIN_PASSWORD:?err}"

# "Anonymous Token" (Client Authorization Header)
# This header identifies the client to the server during startup and auth.
CLIENT="SetupWizard"
DEVICE="DockerScript"
DEVICE_ID="setup-wizard-script"
VERSION="10.11.4"
AUTH_HEADER="MediaBrowser Client=\"$CLIENT\", Device=\"$DEVICE\", DeviceId=\"$DEVICE_ID\", Version=\"$VERSION\""

# Wait for Jellyfin to be ready
wait_for_jellyfin() {
    echo "LOG: Waiting for Jellyfin to be responsive..."
    until curl -s "$JELLYFIN_URL/System/Ping" >/dev/null; do
        sleep 5
    done
    echo "LOG: Jellyfin is up."
}

wait_for_jellyfin

## Check if Startup Wizard is already completed
# Endpoint: /System/Info/Public -> https://api.jellyfin.org/#tag/System/operation/GetPublicSystemInfo
echo "INFO: Checking if startup wizard is completed..."
WIZARD_STATUS=$(curl -s "$JELLYFIN_URL/System/Info/Public" | jq -r '.StartupWizardCompleted')

if [[ "$WIZARD_STATUS" == "true" ]]; then
    echo "INFO: Startup wizard is already completed. Skipping wizard setup."
    exit 0
fi

echo "INFO: Startup wizard is active. Proceeding with setup..."

## Fetch startup user (the query apparently creates it if it doesn't exists)
# Endpoint: /Startup/User -> https://api.jellyfin.org/#tag/Startup/operation/GetFirstUser
echo "INFO: Fetching startup user info..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X GET "$JELLYFIN_URL/Startup/User" \
    -H "X-Emby-Authorization: $AUTH_HEADER")

if [[ "$HTTP_STATUS" == "200" ]]; then
    echo "LOG: Successfully fetched startup user info."
else
    echo "ERROR: Failed to fetch startup user info (Status: $HTTP_STATUS)."
fi

## Create the Admin User (or to be exact, modify its name / password)
# Endpoint: /Startup/User -> https://api.jellyfin.org/#tag/Startup/operation/UpdateStartupUser
echo "INFO: Creating admin user '$JELLYFIN_USER'..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$JELLYFIN_URL/Startup/User" \
    -H "Content-Type: application/json" \
    -H "X-Emby-Authorization: $AUTH_HEADER" \
    -d "{ \"Name\": \"$JELLYFIN_USER\", \"Password\": \"$JELLYFIN_PASSWORD\" }")

if [[ "$HTTP_STATUS" == "204" ]]; then
    echo "LOG: Admin user created."
else
    echo "ERROR: Failed to create admin user (Status: $HTTP_STATUS)."
    exit 1
fi

## Complete the Wizard
# Endpoint: /Startup/Complete -> https://api.jellyfin.org/#tag/Startup/operation/CompleteWizard
echo "INFO: Completing the startup wizard..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$JELLYFIN_URL/Startup/Complete" \
    -H "Content-Type: application/json" \
    -H "X-Emby-Authorization: $AUTH_HEADER" \
    -d '[]')

if [[ "$HTTP_STATUS" == "200" || "$HTTP_STATUS" == "204" ]]; then
    echo "LOG: Wizard completed successfully."
else
    echo "ERROR: Failed to complete startup wizard (Status: $HTTP_STATUS)."
    exit 1
fi

