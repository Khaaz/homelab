#!/bin/sh

# Prerequesites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
DIRNAME=$(get_script_dir)

## Usage
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input-directory> <output-directory>"
  exit 1
fi

## Variables
INPUT_DIR="$1"
OUTPUT_DIR="$2"

## Input verification
# Check if the input directory exists
if [ ! -d "$INPUT_DIR" ]; then
  echo "Error: Input directory does not exist: $INPUT_DIR"
  exit 1
fi

## Core
# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to recursively process each file
process_files() {
  local current_dir="$1"

  # Iterate through all files and subdirectories in the current directory
  for file in "$current_dir"/*; do

    # If it's a directory, recurse into it
    if [ -d "$file" ]; then
      new_dir="$OUTPUT_DIR/$(basename "$file")"
      process_files "$file"

    elif [ -f "$file" ]; then
      # If it's a file, parse it and save to the corresponding output folder
      output_file="$(echo "$file" | sed "s|^$INPUT_DIR|$OUTPUT_DIR|")"
      mkdir -p "$(dirname "$output_file")"
      $DIRNAME/parse-file.sh "$file" "$output_file"
    fi
  done
}

# Start the processing from the input directory
echo "FOLDER_PARSER: Processing folder '$INPUT_DIR' as '$OUTPUT_DIR'..."
process_files "$INPUT_DIR"

if [ $? -eq 0 ]; then
  echo "FOLDER_PARSER: Success => Successfully parsed folder."
  exit 0
else
  echo "FOLDER_PARSER: Error => Failed to parse folder."
  exit 1
fi