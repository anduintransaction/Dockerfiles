#!/bin/bash
INFLUXDB_ADDR=52.0.110.234

# data only docker
sudo docker pull anduin/log_data
sudo docker run --name log_data -v /mnt/elasticsearch/data:/mnt/elasticsearch/data anduin/log_data

sudo docker pull anduin/influxdb_data
sudo docker run --name influxdb_data -v /mnt/influxdb:/mnt anduin/influxdb_data

# ElasticSearch Kibana
sudo docker pull anduin/es_kibana
sudo docker run --name es_kibana \
    --volumes-from log_data \
    -p 8080:80 -p 9200:9200 -d anduin/es_kibana


ESK_ADDR=`sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' es_kibana`
curl -XPUT http://${ESK_ADDR}:9200/_template/logstash -d@es_kibana/config/kibana/template.json

# InfluxDB and Grafana
sudo docker pull anduin/grafana-influxdb
sudo docker run -d -v /etc/localtime:/etc/localtime:ro \
	-p 80:80 -p 8083:8083 -p 8084:8084 -p 8086:8086 \
	-e INFLUXDB_ADDR=$INFLUXDB_ADDR
    --volumes-from influxdb_data \
	--name grafana-influxdb anduin/grafana_influxdb

# Fluentd
sudo docker pull anduin/fluentd
sudo docker run --name=fluentd -p 42185:42185/udp \
       --link es_kibana:esk --link grafana-influxdb:ixdb -d \
       anduin/fluentd

#       -v /var/lib/docker/containers:/var/lib/docker/containers \
#       -v /var/log/docker:/var/log/docker \
