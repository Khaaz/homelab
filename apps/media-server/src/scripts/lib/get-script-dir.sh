#!/bin/sh

get_script_dir() {
    # Get the directory of the currently running script
    SCRIPT_DIR=$(dirname "$(realpath "$0")")
    echo "$SCRIPT_DIR"
}