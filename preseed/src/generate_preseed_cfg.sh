#!/bin/sh

# Prerequisites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
DIRNAME=$(get_script_dir)

## Usage
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <output-file>"
  exit 1
fi

OUTPUT_FILE="$1"
INPUT_FILE="$DIRNAME/templates/preseed.cfg"

## Core
# Source environment variables from ./config/.env (standard env file)
ENV_FILE="$DIRNAME/config/.env"
if [ -f "$ENV_FILE" ]; then
  set -a
  . "$ENV_FILE"
  set +a
else
  echo "Warning: Env file not found: $ENV_FILE"
fi

# Call the parse-file script
SCRIPT_ROOT="$DIRNAME/../../src/app-bootstrap/parse-file.sh"
if [ ! -f "$SCRIPT_ROOT" ]; then
  echo "Error: parse-file.sh not found at $SCRIPT_ROOT"
  exit 1
fi

sh "$SCRIPT_ROOT" "$INPUT_FILE" "$OUTPUT_FILE"