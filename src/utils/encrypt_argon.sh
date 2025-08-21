#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 <password>"
	exit 1
fi

PASSWORD="$1"

echo -n "$PASSWORD" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4
