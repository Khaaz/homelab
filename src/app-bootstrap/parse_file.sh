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
	echo "Usage: $0 <path_to_input_file> <path_to_output_file>"
	exit 1
}

## Input verification
if [ "$#" -ne 2 ]; then
	usage
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
	echo "Error: Input file does not exist: $INPUT_FILE"
	exit 1
fi

#
## Core
#
sh "$SCRIPT_DIR/lib/install_dependencies.sh" gettext

echo "FILE_PARSER: Processing file '$INPUT_FILE' as '$OUTPUT_FILE'..."
parse_file $INPUT_FILE > $OUTPUT_FILE

if [ $? -eq 0 ]; then
	echo "FILE_PARSER: Success => Successfully processed file. Output written to: $OUTPUT_FILE"
else
	echo "FILE_PARSER: Error => Failed to process file."
	exit 1
fi
