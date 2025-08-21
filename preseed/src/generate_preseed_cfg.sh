#!/bin/sh

# Prerequisites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Usage
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path_to_output_file>"
  exit 1
fi

OUTPUT_FILE="$1"
INPUT_FILE="$SCRIPT_DIR/templates/preseed.cfg"

## Core
# Source environment variables from ./config/.env (standard env file)
GENERATED_ENV_FILE="$SCRIPT_DIR/config/generated.env"
ENV_FILE="$SCRIPT_DIR/config/.env"
if [ -f "$GENERATED_ENV_FILE" ]; then
  set -a
  . "$GENERATED_ENV_FILE"
  set +a
else
  echo "Warning: .env.generated file not found: $GENERATED_ENV_FILE"
fi
if [ -f "$ENV_FILE" ]; then
  set -a
  . "$ENV_FILE"
  set +a
else
  echo "Warning: .env file not found: $ENV_FILE"
fi

# Call the parse_file script
PARSE_FILE_SCRIPT_PATH="$SCRIPT_DIR/../../src/app-bootstrap/parse_file.sh"
if [ ! -f "$PARSE_FILE_SCRIPT_PATH" ]; then
  echo "Error: parse_file.sh not found at $PARSE_FILE_SCRIPT_PATH"
  exit 1
fi

sh "$PARSE_FILE_SCRIPT_PATH" "$INPUT_FILE" "$OUTPUT_FILE"
