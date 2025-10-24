# Docku

1. Create an htpasswd file with bcrypt-encrypted passwords:

```
htpasswd -cbB .htpasswd admin yourpassword
```

2. Make cretificate for SSL

```
mkdir ssl
mkcert -key-file ./ssl/key.pem -cert-file ./ssl/cert.pem example.com *.example.com
```

3. Launch Doku

```
docker compose up -d
```

See move https://github.com/amerkurev/doku
