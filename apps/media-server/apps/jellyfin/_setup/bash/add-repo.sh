#!/bin/bash
sleep 15

SYSTEM_XML="../../config/system.xml"
REPO_XML="./_setup/bash/repositories.xml"
BACKUP_FILE="system.xml.bak"

# Vérifications
[[ ! -f "$SYSTEM_XML" ]] && { echo "❌ $SYSTEM_XML introuvable"; exit 1; }
[[ ! -f "$REPO_XML" ]] && { echo "❌ $REPO_XML introuvable"; exit 1; }

# Installer xmlstarlet si nécessaire
if ! command -v xmlstarlet &> /dev/null; then
  echo "⚙️ Installation de xmlstarlet..."
  sudo apt update -qq && sudo apt install -y xmlstarlet
fi

# Sauvegarde
cp "$SYSTEM_XML" "$BACKUP_FILE"
echo "✅ Sauvegarde créée : $BACKUP_FILE"

# Compter les dépôts existants
count_before=$(xmlstarlet sel -t -v "count(//PluginRepositories/RepositoryInfo)" "$SYSTEM_XML")

# Extraire les RepositoryInfo du fichier source
mapfile -t repos < <(xmlstarlet sel -t -m "//PluginRepositories/RepositoryInfo" -v "concat(Name,'|',Url,'|',Enabled)" -n "$REPO_XML")

count_added=0
for repo in "${repos[@]}"; do
    IFS="|" read -r name url enabled <<< "$repo"

    # Vérifier si l'URL existe déjà dans system.xml
    exists=$(xmlstarlet sel -t -v "count(//PluginRepositories/RepositoryInfo[Url='$url'])" "$SYSTEM_XML")
    if [[ "$exists" -eq 0 ]]; then
        # Ajouter le RepositoryInfo à system.xml
        xmlstarlet ed -L -s "//PluginRepositories" -t elem -n "RepositoryInfoTMP" -v "" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Name" -v "$name" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Url" -v "$url" "$SYSTEM_XML"
        xmlstarlet ed -L -s "//PluginRepositories/RepositoryInfoTMP[last()]" -t elem -n "Enabled" -v "$enabled" "$SYSTEM_XML"
        xmlstarlet ed -L -r "//PluginRepositories/RepositoryInfoTMP[last()]" -v "RepositoryInfo" "$SYSTEM_XML"

        ((count_added++))
    fi
done

echo "✅ $count_added dépôts ajoutés depuis $REPO_XML à $SYSTEM_XML (sans doublons)."
