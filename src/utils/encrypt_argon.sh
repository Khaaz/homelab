#!/bin/sh

usage() {
	echo "Usage: $0 <password>"
	exit 1
}

if [ -z "$1" ]; then
	usage
fi

PASSWORD="$1"

echo -n "$PASSWORD" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4
