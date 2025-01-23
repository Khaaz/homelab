#!/bin/sh

echo "LOL"
## root
# root cert
cp /app/certs/root.crt /swag/www/root.crt

## domain
# domain cert
cp /app/certs/$DOMAIN/cert.pem /swag/keys-private/cert.crt
# domain key
cp /app/certs/$DOMAIN/key.pem /swag/keys-private/cert.key