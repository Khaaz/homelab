#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

password="$1"

openssl passwd -6 "$password"
