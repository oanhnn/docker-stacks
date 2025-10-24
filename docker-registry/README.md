# Docker registry

1. Create an htpasswd file with bcrypt-encrypted passwords:

```
htpasswd -cbB .htpasswd <ussername> <password>
```

or

```
docker run --entrypoint htpasswd httpd:2 -Bbn <ussername> <password> > .htpasswd
```

2. Make cretificate for SSL

```
mkdir ssl
mkcert -key-file ./certs/key.pem -cert-file ./certs/cert.pem example.com *.example.com
```

3. Launch Doku

```
docker compose up -d
```

See move https://distribution.github.io/distribution/about/deploying/
