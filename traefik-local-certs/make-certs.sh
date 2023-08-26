#!/bin/bash

IP=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
DOMAIN="${IP//\./-}.nip.io"

mkcert -install
mkcert -key-file traefik/certs/key.pem -cert-file traefik/certs/cert.pem $DOMAIN *.$DOMAIN

cp $(mkcert -CAROOT)/rootCA.pem traefik/certs/rootCA.pem
