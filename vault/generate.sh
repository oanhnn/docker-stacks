#!/bin/bash

# Generate private key
openssl genrsa -out vault-key.pem 4096

# Generate CSR
openssl req -new -key vault-key.pem \
    -subj "/O=system:nodes/CN=system:node:" \
    -out ${TMPDIR}/server.csr \
    -config ${TMPDIR}/csr.conf