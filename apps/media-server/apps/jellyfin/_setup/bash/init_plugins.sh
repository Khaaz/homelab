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

# Plugins to install (Package Name)
PLUGINS=(
    "Intro Skipper"
    "File Transformation"
    "InPlayerEpisodePreview"
    "Home Screen Sections"
    "Skin Manager"
    "SSO Authentication"
	"Open Subtitles"
	"TheTVDB"
)

# Repositories to add (Name|Url)
REPOS=(
    "Jellyfin Stable|https://repo.jellyfin.org/files/plugin/manifest.json"
    "intro-skipper|https://intro-skipper.org/manifest.json"
	"File Transformation|https://www.iamparadox.dev/jellyfin/plugins/manifest.json"
	"InPlayerEpisodePreview|https://raw.githubusercontent.com/Namo2/InPlayerEpisodePreview/master/manifest.json"
	"jellyfin-plugin-home-sections|https://www.iamparadox.dev/jellyfin/plugins/manifest.json"
	"Skin manager|https://raw.githubusercontent.com/danieladov/JellyfinPluginManifest/master/manifest.json"
	"Jellyfin SSO|https://raw.githubusercontent.com/9p4/jellyfin-plugin-sso/manifest-release/manifest.json"
)

# Wait for Jellyfin to be ready
wait_for_jellyfin() {
    echo "LOG: Waiting for Jellyfin to be responsive..."
    until curl -s "$JELLYFIN_URL/System/Ping" >/dev/null; do
        sleep 5
    done
    echo "LOG: Jellyfin is up."
}

wait_for_jellyfin

## Authenticate to get Access Token
# Endpoint: /Users/AuthenticateByName -> https://api.jellyfin.org/#tag/Users/operation/AuthenticateByName
echo "INFO: Authenticating as $JELLYFIN_USER..."
AUTH_RESPONSE=$(curl -s -X POST "$JELLYFIN_URL/Users/AuthenticateByName" \
    -H "Content-Type: application/json" \
    -H "X-Emby-Authorization: $AUTH_HEADER" \
    -d "{
        \"Username\": \"$JELLYFIN_USER\",
        \"Pw\": \"$JELLYFIN_PASSWORD\"
    }")

TOKEN=$(echo "$AUTH_RESPONSE" | jq -r '.AccessToken')

if [[ "$TOKEN" == "null" || -z "$TOKEN" ]]; then
    echo "ERROR: Authentication failed. Please check credentials or if setup wizard is completed."
    exit 1
fi

echo "INFO: Authentication successful. Token acquired."

## Add Repositories (Batch)
echo "INFO: Configuring repositories..."

# Build JSON array of repositories
REPO_JSON="[]"
for repo_entry in "${REPOS[@]}"; do
    IFS="|" read -r name url <<< "$repo_entry"
    REPO_JSON=$(echo "$REPO_JSON" | jq --arg n "$name" --arg u "$url" \
        '. + [{"Name": $n, "Url": $u, "Enabled": true}]')
done

# Sets the entire list of repositories (replacing existing ones or updating them)
# Endpoint: /Repositories -> https://api.jellyfin.org/#tag/Package/operation/SetRepositories
REPO_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$JELLYFIN_URL/Repositories" \
    -H "X-Emby-Token: $TOKEN" \
    -H "Content-Type: application/json" \
    -d "$REPO_JSON")

if [[ "$REPO_RESPONSE" == "200" || "$REPO_RESPONSE" == "204" ]]; then
     echo "LOG: Repositories configured successfully."
else
     echo "ERROR: Failed to set repositories (HTTP $REPO_RESPONSE)."
     echo "Debug: JSON sent: $REPO_JSON"
fi


## Install Plugins
echo "INFO: Installing plugins..."

# Debug: List available packages to confirm repos are working
# Endpoint: /Packages -> https://api.jellyfin.org/#tag/Package/operation/GetPackages
# echo "DEBUG: Fetching available packages list..."
# AVAILABLE_PACKAGES=$(curl -s -X GET "$JELLYFIN_URL/Packages" \
#     -H "X-Emby-Token: $TOKEN")
# echo "DEBUG: Available packages found:"
# echo "$AVAILABLE_PACKAGES" | jq -r '.[].name' || echo "Raw response: $AVAILABLE_PACKAGES"

# Check installed plugins
# Endpoint: /Plugins -> https://api.jellyfin.org/#tag/Plugins/operation/GetPlugins
INSTALLED_PLUGINS_JSON=$(curl -s -X GET "$JELLYFIN_URL/Plugins" \
    -H "X-Emby-Token: $TOKEN")

INSTALLED_PLUGINS=$(echo "$INSTALLED_PLUGINS_JSON" | jq -r '.[].Name')

# Check if all desired plugins are installed
ALL_INSTALLED=true
for plugin in "${PLUGINS[@]}"; do
    if ! echo "$INSTALLED_PLUGINS" | grep -Fqx "$plugin"; then
        ALL_INSTALLED=false
        break
    fi
done

if [ "$ALL_INSTALLED" = true ]; then
    echo "INFO: All desired plugins are already installed. Skipping installation"
    exit 0
fi

for plugin in "${PLUGINS[@]}"; do
    echo "LOG: Requesting installation for: $plugin"
    
    # Replace spaces with %20 for the URL
    ENCODED_PLUGIN="${plugin// /%20}"

    # Install package by name (server attempts to resolve latest)
    # Endpoint: /Packages/Installed/{Name} -> https://api.jellyfin.org/#tag/Package/operation/InstallPackage
    RESPONSE=$(curl -s -w "%{http_code}" -X POST "$JELLYFIN_URL/Packages/Installed/$ENCODED_PLUGIN" \
        -H "X-Emby-Token: $TOKEN" \
        -H "Content-Type: application/json")

    if [[ "$RESPONSE" == "204" || "$RESPONSE" == "200" ]]; then
        echo "LOG: Successfully installed plugin: $plugin"
    else
        echo "ERROR: Failed to install plugin: $plugin (HTTP $RESPONSE)."
    fi
done

echo "INFO: Plugin installation requests completed."

## Reboot Jellyfin
# Endpoint: /System/Restart -> https://api.jellyfin.org/#tag/System/operation/RestartApplication
echo "INFO: Restarting Jellyfin..."
RESTART_RESPONSE=$(curl -s -w "%{http_code}" -X POST "$JELLYFIN_URL/System/Restart" \
    -H "X-Emby-Token: $TOKEN" \
    -H "Content-Type: application/json")

if [[ "$RESTART_RESPONSE" == "204" || "$RESTART_RESPONSE" == "200" ]]; then
    echo "LOG: Restart command sent successfully."
else
    echo "ERROR: Failed to restart Jellyfin (HTTP $RESTART_RESPONSE)."
fi
