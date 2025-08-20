#!/bin/bash

# Prerequesites
get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

# Execute the generate_env command
$SCRIPT_DIR/generate_env/main.sh
