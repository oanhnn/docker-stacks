# Dgraph

Dgraph is a horizontally scalable and distributed GraphQL database with a graph backend. 
It provides ACID transactions, consistent replication, and linearizable reads. 
It's built from the ground up to perform for a rich set of queries. Being a native GraphQL database, 
it tightly controls how the data is arranged on disk to optimize for query performance and throughput,
reducing disk seeks and network calls in a cluster.

Dgraph's goal is to provide [Google](https://www.google.com) production level scale and throughput,
with low enough latency to be serving real-time user queries, over terabytes of structured data.
Dgraph supports [GraphQL query syntax](https://dgraph.io/docs/master/query-language/), and responds in [JSON](http://www.json.org/) and [Protocol Buffers](https://developers.google.com/protocol-buffers/) over [gRPC](http://www.grpc.io/) and HTTP.

## Prepare

Create Docker network `dgragh-net` and Docker volume `dgragh-vol`.

```yml
# docker-compose.override.yml
version: "3.5"

networks:
  dgraph-net:
    name: database-net

volumes:
  dgraph-vol:
    name: dgraph-vol
```

## Deploy

### Standalone stack

A standalone stack is Dgragh Zero and Alpha will be running in a Docker container

// TODO:

- With `docker-compose`:

```shell
docker-compose -f docker-compose.yml up -d
```

- With `Docker Swam`:

```shell
docker stack deploy -f docker-compose.yml dgraph
```

### Simple stack

A simple stack is Dgraph Zero and Alpha will be running in different Docker containers

// TODO:

- With `docker-compose`:

```shell
docker-compose -f docker-compose.simple.yml up -d
```

- With `Docker Swam`:

```shell
docker stack deploy -f docker-compose.simple.yml dgraph
```

### Multi alpha stack

// TODO:

### High Availability stack

// TODO:

## Refs

- https://dgraph.io/docs
- https://github.com/dgraph-io/dgraph

