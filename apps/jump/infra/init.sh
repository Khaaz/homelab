#!/bin/sh

# Install base packages for jump VM
apk add --no-cache bash net-tools iputils iproute2 bind-tools nmap

# Install generate env packages (passwords)
apk add --no-cache argon2 apache2-utils

# Install Python and pip
apk add --no-cache python3 py3-pip

# Install ansible
apk add ansible
