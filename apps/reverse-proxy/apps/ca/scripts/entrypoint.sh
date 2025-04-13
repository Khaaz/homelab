#!/bin/sh

## Generate certs
/app/minica/minica -ca-key root.key -ca-cert root.crt --domains $DOMAIN,*.$DOMAIN -common-name "Homelab"

## root
# root cert
cp /app/certs/root.crt /swag/www/root.crt

## domain
# domain cert
cp /app/certs/$DOMAIN/cert.pem /swag/keys-private/cert.crt
# domain key
cp /app/certs/$DOMAIN/key.pem /swag/keys-private/cert.key