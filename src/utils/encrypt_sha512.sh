#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: $0 <password>"
	exit 1
fi

PASSWORD="$1"

openssl passwd -6 "$PASSWORD"
