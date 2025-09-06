#!/bin/sh

## Usage
usage() {
	echo "Usage: $0 <password>"
	exit 1
}

## Input verification
if [ -z "$1" ]; then
	usage
fi
PASSWORD="$1"

#
## Core
#
openssl passwd -6 "$PASSWORD"
