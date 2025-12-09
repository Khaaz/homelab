#!/bin/sh

## Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

## Import
# Import the parse file function
. $SCRIPT_DIR/lib/parse_file.sh

## Usage
usage() {
	echo "Usage: $0 <path_to_input_file> <path_to_output_file> [to_replace]"
	exit 1
}

## Input verification
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
	usage
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"
TO_REPLACE="${3:-true}"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: Input file does not exist: $INPUT_FILE"
	exit 1
fi

if [ "$TO_REPLACE" = "false" ] && [ -f "$OUTPUT_FILE" ]; then
	echo "FILE_PARSER: Output file exists and replacement is disabled. Skipping: $OUTPUT_FILE"
	exit 0
fi

#
## Core
#
sh "$SCRIPT_DIR/lib/install_dependencies.sh" gettext

echo "FILE_PARSER: Processing file '$INPUT_FILE' as '$OUTPUT_FILE'..."
parse_file $INPUT_FILE > $OUTPUT_FILE

if [ -n "$PUID" ] && [ -n "$PGID" ]; then
	echo "FILE_PARSER: Setting ownership of '$OUTPUT_FILE' to '$PUID:$PGID'"
	chown $PUID:$PGID $OUTPUT_FILE
fi

if [ $? -eq 0 ]; then
	echo "FILE_PARSER: Success => Successfully processed file. Output written to: $OUTPUT_FILE"
else
	echo "FILE_PARSER: Error => Failed to process file."
	exit 1
fi
