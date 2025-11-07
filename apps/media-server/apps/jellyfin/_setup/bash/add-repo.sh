#!/bin/bash
sleep 15

SYSTEM_XML="../../config/system.xml"
REPO_XML="./_setup/bash/repositories.xml"
BACKUP_FILE="system.xml.bak"

# Checks
[[ ! -f "$SYSTEM_XML" ]] && { echo "$SYSTEM_XML not found"; exit 1; }
[[ ! -f "$REPO_XML" ]] && { echo "$REPO_XML not found"; exit 1; }

# Install xmlstarlet if needed
if ! command -v xmlstarlet &> /dev/null; then
  echo "Installing xmlstarlet..."
  sudo apt update -qq && sudo apt install -y xmlstarlet
fi

# Backup
cp "$SYSTEM_XML" "$BACKUP_FILE"
echo "Backup created: $BACKUP_FILE"

# Count existing repos
count_before=$(xmlstarlet sel -t -v "count(//PluginRepositories/RepositoryInfo)" "$SYSTEM_XML")

# Extract RepositoryInfo from source file
mapfile -t repos < <(xmlstarlet sel -t -m "//PluginRepositories/RepositoryInfo" -v "concat(Name,'|',Url,'|',Enabled)" -n "$REPO_XML")

count_added=0
for repo in "${repos[@]}"; do
    IFS="|" read -r name url enabled <<< "$repo"

    # Check if URL already exists in system.xml
    exists=$(xmlstarlet sel -t -v "count(//PluginRepositories/RepositoryInfo[Url='$url'])" "$SYSTEM_XML")
    if [[ "$exists" -eq 0 ]]; then
        # Add RepositoryInfo to system.xml
        xmlstarlet ed -L -s "//PluginRepositories" -t elem -n "RepositoryInfoTMP" -v "" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Name" -v "$name" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Url" -v "$url" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Enabled" -v "$enabled" "$SYSTEM_XML"
        xmlstarlet ed -L -r "//PluginRepositories/RepositoryInfoTMP[last()]" -v "RepositoryInfo" "$SYSTEM_XML"

        ((count_added++))
    fi
done

echo "$count_added repos added from $REPO_XML to $SYSTEM_XML (without duplicates)."
