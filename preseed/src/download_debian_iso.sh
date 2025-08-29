#!/bin/sh

# Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

URL="https://cdimage.debian.org/cdimage/archive/12.9.0/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso"
ISO_NAME="debian-12.9.0-amd64-netinst.iso"
EXPECTED_SHA512="9ebe405c3404a005ce926e483bc6c6841b405c4d85e0c8a7b1707a7fe4957c617ae44bd807a57ec3e5c2d3e99f2101dfb26ef36b3720896906bdc3aaeec4cd80"

# Paths
ROOT_PATH="$SCRIPT_DIR/.."
ISO_DIR="$ROOT_PATH/iso"
TARGET_FILE="$ISO_DIR/$ISO_NAME"

echo "LOG: Preparing to download Debian ISO"
echo "LOG: Context - ISO dir: $ISO_DIR"
echo "LOG: Context - Target file: $TARGET_FILE"

mkdir -p "$ISO_DIR"

verify_checksum() {
	actual=$(sha512sum "$1" | awk '{print $1}')
	if [ "$actual" = "$EXPECTED_SHA512" ]; then
		return 0
	else
		return 1
	fi
}

download_with_curl() {
	curl -fL --retry 3 --retry-delay 3 -o "$1" "$2"
}

download_with_wget() {
	wget -O "$1" "$2"
}

# If file already exists and checksum matches, skip download
if [ -f "$TARGET_FILE" ]; then
	echo "LOG: Found existing ISO at $TARGET_FILE, verifying checksum"
	if verify_checksum "$TARGET_FILE"; then
		echo "LOG: Checksum OK. Nothing to do."
		exit 0
	else
		echo "WARN: Existing file checksum mismatch. Re-downloading..."
		rm -f "$TARGET_FILE"
	fi
fi

TMP_FILE="$TARGET_FILE.part"
rm -f "$TMP_FILE"

echo "LOG: Downloading ISO from $URL"
if command -v curl >/dev/null 2>&1; then
	download_with_curl "$TMP_FILE" "$URL" || {
		echo "Error: curl download failed"
		rm -f "$TMP_FILE"
		exit 1
	}
elif command -v wget >/dev/null 2>&1; then
	download_with_wget "$TMP_FILE" "$URL" || {
		echo "Error: wget download failed"
		rm -f "$TMP_FILE"
		exit 1
	}
else
	echo "Error: Neither curl nor wget is installed"
	exit 1
fi

echo "LOG: Verifying SHA-512 checksum"
if verify_checksum "$TMP_FILE"; then
	mv "$TMP_FILE" "$TARGET_FILE"
	echo "LOG: ISO downloaded and verified: $TARGET_FILE"
	exit 0
else
	echo "Error: Checksum verification failed"
	rm -f "$TMP_FILE"
	exit 1
fi


