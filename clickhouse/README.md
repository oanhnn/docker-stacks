# Clickhouse

https://clickhouse.com/docs/install/docker

1. Create docker network

```
docker network create database-net
```

2. Create docker volumes

```
docker volume create clickhouse-vol
docker volume create clickhouse-log
```
3. Create environment file

```
touch .env
echo "CLICKHOUSE_DB=defaultdb" >> .env
echo "CLICKHOUSE_USER=dbmaster" >> .env
echo "CLICKHOUSE_PASSWORD=Pa55wOrd!" >> .env
```

4. Start ClickHouse

```
docker compose up -d
```
