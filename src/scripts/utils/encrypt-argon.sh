#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

password="$1"

echo -n "$password" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4
