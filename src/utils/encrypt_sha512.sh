#!/bin/sh

usage() {
	echo "Usage: $0 <password>"
	exit 1
}

if [ -z "$1" ]; then
	usage
fi

PASSWORD="$1"

openssl passwd -6 "$PASSWORD"
