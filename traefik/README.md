# Traefik

https://doc.traefik.io/traefik/

Traefik is an open-source Edge Router that makes publishing your services a fun and easy experience. 
It receives requests on behalf of your system and finds out which components are responsible for handling them.

## Prepare

1. Set environment variables

```shell
export DOMAIN=example.com
export EMAIL=admin@example.com
export USERNAME=admin
export HASHED_PASSWORD="$(openssl passwd -apr1)"
```

2. If deploy to Docker Swarm, please add label to deploying node

```sheel
docker node update --label-add "node-has-traefik=true" $(docker info -f '{{.Swarm.NodeID}}')
```

3. Make `docker-compose.override.yml`

```yml
version: "3.5"

# Networks
networks:
  proxy-net:
    name: reverse-proxy

# Secrets
secrets:
  linode-token:
    name: linode-token
    file: ./secrets/linode-token.txt

# Volumes
volumes:
  certs-vol:
    name: certs-vol
```

## Deploy

### Docker compose

```shell
docker-compose up -d
```

### Docker Swarm

```shell
docker stack deploy traefik-proxy -c docker-stack.yml
```