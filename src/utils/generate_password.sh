#!/bin/sh

## Usage
usage() {
	echo "Usage: $0 <size>"
	exit 1
}

## Input verification
if [ -z "$1" ]; then
	usage
fi
SIZE="$1"

#
## Core
#
tr -dc 'A-Za-z0-9!@%^*()_+=-{}[]<>?' </dev/urandom | head -c "$SIZE"
