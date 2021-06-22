# InfluxDB

https://docs.influxdata.com/influxdb/v2.0/

The InfluxDB 2.0 time series platform is purpose-built to collect, store, process and visualize metrics and events


## Setup

```
docker-compose up -d
docker-compose exec influxdb influx setup \
      --username $USERNAME \
      --password $PASSWORD \
      --org $ORGANIZATION \
      --bucket $BUCKET
```

TODO: healthy check
