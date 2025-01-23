#!/bin/sh

parse_file() {
  local input_file="$1"

  if [ ! -f "$input_file" ]; then
    echo "Error: Input file does not exist: $input_file" >&2
    return 1
  fi

  cat $input_file | envsubst "$(env | cut -d = -f 1 | sed 's/^/$/' | tr '\n' ' ')"

  # Read and process the input file line by line
  # while IFS= read -r line || [ -n "$line" ]; do
  #     # Use sed to replace occurrences of the environment variable in the line
  #   line2=$(echo "$line" | sed -e "s/\$\([a-zA-Z_][a-zA-Z0-9_]*\)/$\1/g")
  #   echo $line2
  #   # cmd=(echo $line2)
  #   # echo $(token_quote "$line2")
  # done < "$input_file"
}