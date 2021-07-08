# Docker compose stacks

## Stacks

- [x] Adminer
- [x] Dgraph
- [x] Focalboard
- [x] Ghost
- [x] InfluxDB
- [x] MySQL
- [x] MinIO
- [ ] Penpot
- [x] PostgreSQL
- [x] QuestDB
- [x] Redis
- [x] Redoc
- [ ] Traefik proxy

## Prepare

- File `docker-stack*.yml` for running `docker stack deploy` on Docker Swarm cluster.
- File `docker-compose*.yml` for running `docker-compose up` on Docker Machine.
- Before run stack, you must create Docker networks, Docker volumes, Docker secrets or Docker configs.
  You can mockup by `docker-compose.override.yml` file follow https://docs.docker.com/compose/extends/
