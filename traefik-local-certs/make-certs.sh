#!/bin/sh

$DOMAINS="$1.test *.$1.test"

mkcert -key-file traefik/certs/key.pem -cert-file traefik/certs/cert.pem $DOMAINS
