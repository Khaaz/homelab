#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input-file> <output-file>"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: Input file does not exist: $INPUT_FILE"
  exit 1
fi

# Create or overwrite the output file
> "$OUTPUT_FILE"

# Read and process the input file line by line
echo "Processing file '$INPUT_FILE' as '$OUTPUT_FILE'..."
while IFS= read -r line || [ -n "$line" ]; do
  # Evaluate the line to replace environment variables
  eval "echo \"$line\"" >> "$OUTPUT_FILE"
done < "$INPUT_FILE"

if [ $? -eq 0 ]; then
  echo "Successfully processed file. Output written to: $OUTPUT_FILE"
else
  echo "Error: Failed to process file."
  exit 1
fi