#!/bin/sh

. /scripts/lib/get-script-dir.sh
DIRNAME=$(get_script_dir)

# Import the parse file function
. $DIRNAME/lib/parse-file.sh

# Import the dependencies function
. $DIRNAME/lib/install-dependencies.sh

## Usage
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input-file> <output-file>"
  exit 1
fi

## Variables
INPUT_FILE="$1"
OUTPUT_FILE="$2"

## Input verification
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: Input file does not exist: $INPUT_FILE"
  exit 1
fi

## Core
install_dependencies gettext

echo "INIT: Processing file '$INPUT_FILE' as '$OUTPUT_FILE'..."
parse_file $INPUT_FILE > $OUTPUT_FILE

if [ $? -eq 0 ]; then
  echo "INIT: Success => Successfully processed file. Output written to: $OUTPUT_FILE"
  exit 0
else
  echo "INIT: Error => Failed to process file."
  exit 1
fi