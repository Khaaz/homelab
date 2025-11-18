#!/bin/sh

## Usage
usage() {
	echo "Usage: $0 <to_encode>"
	exit 1
}

## Input verification
if [ -z "$1" ]; then
	usage
fi
TO_ENCODE="$1"

#
## Core
#
echo -n "$TO_ENCODE" | argon2 "$(openssl rand -hex 16)" -id -e -k 65536 -t 3 -p 4
