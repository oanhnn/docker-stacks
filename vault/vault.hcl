ui = true

log_level = "Info"
log_format = "standard"

cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"

listener "tcp" {
    # Specifies the address to bind to for listening.
    address = "0.0.0.0:8200"

    # Specifies the address to bind to for server-to-server requests.
    cluster_address = "0.0.0.0:8201"

    tls_disable = "true"
    # tls_key_file = "/certs/vault-key.pem"
    # tls_cert_file = "/certs/vault-cert.pem"
    # tls_min_version = "tls12"
    # tls_cipher_suites = ""

    # tls_require_and_verify_client_cert = "true"
    # tls_client_ca_file = "/certs/ca-cert.pem"
}

storage "inmem" {}

# storage "mysql" {
#     address = "mysql:3306"
#     database = "vaultdb"
#     table = "vaults"
#     username = "user1234"
#     password = "secret123!"
# }
