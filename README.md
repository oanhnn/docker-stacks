# Docker compose stacks

## Database

- [x] Adminer
- [x] Dgraph
- [x] InfluxDB
- [x] MySQL
- [x] PostgreSQL
- [x] QuestDB
- [x] Redis
- [x] Timescaledb

## Storage

- [x] MinIO

## Proxy

- [ ] Traefik proxy

## Design

- [ ] Penpot

## Low code

- Metabase

## Production

- [x] Ghost
- [x] Focalboard
- [x] Redoc

## Demo


## Prepare

- File `compose.yml` follow [compose-spec](https://github.com/compose-spec/compose-spec/blob/master/spec.md). It requires Docker Compose 1.27.0+ and Docker Engine 19.03.0+
- File `docker-stack*.yml` for running `docker stack deploy` on Docker Swarm cluster.
- File `docker-compose*.yml` for running `docker-compose up` on Docker Machine.
- Before run stack, you must create Docker networks, Docker volumes, Docker secrets or Docker configs.
  You can mockup by `docker-compose.override.yml` file follow https://docs.docker.com/compose/extends/
