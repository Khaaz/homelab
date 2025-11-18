#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
usage() {
	echo "Usage: $0 <domain> [output_folder]"
	exit 1
}

## Input verification
if [ "$#" -lt 1 ]; then
	usage
fi

DOMAIN="$1"

OUT_FILE="$DOMAIN.crt"

DEFAULT_OUT_FOLDER="/usr/local/share/ca-certificates"
OUT_FOLDER=""
if [ -n "$2" ]; then
	OUT_FOLDER="$2"
fi

#
## Core
#
sh "$SCRIPT_DIR/lib/install_dependencies.sh" curl ca-certificates

# Build URL: use as-is if scheme present, otherwise default to https://
base="${DOMAIN%/}"
if [[ "$base" == *"://"* ]]; then
  URL="${base}/ca"
else
  URL="https://${base}/ca"
fi

# Accept untrusted (self-signed) TLS with -k
curl -k -fsSL "$URL" -o "$DEFAULT_OUT_FOLDER/$OUT_FILE"

if [ -n "$OUT_FOLDER" ]; then
	curl -k -fsSL "$URL" -o "$OUT_FOLDER/$OUT_FILE"
fi

update-ca-certificates

echo "TRUST_CERTIFICATE: Wrote root certificate to $DEFAULT_OUT_FOLDER/$OUT_FILE"
if [ -n "$OUT_FOLDER" ]; then
	echo "TRUST_CERTIFICATE: Wrote root certificate to $OUT_FOLDER/$OUT_FILE"
fi
