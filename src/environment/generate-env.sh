#!/bin/bash

# Prerequesites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
DIRNAME=$(get_script_dir)

# Execute the generate-env command
$DIRNAME/generate-env/main.sh
