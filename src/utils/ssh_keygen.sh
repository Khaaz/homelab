#!/bin/sh

ssh-keygen -t rsa -b 4096 -N "" -C "" "$@"
