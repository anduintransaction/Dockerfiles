#!/bin/bash

#!!!!!!!!!!! SET THIS ADDRESS FIRST !!!!!!!!!!!!!!!!
INFLUXDB_ADDR="changeMe"
INFLUXDB_PASSWORD="changeMePlease"
INFLUXDB_ROOT_PASSWORD="changeMePlease"
HTTP_USER="anduin"
HTTP_PASSWORD="changeMePlease"

if [ "${INFLUXDB_ADDR}" = "changeMe" ]; then
    echo "Please specify InfluxDB address."
    echo "Nothing is gonna happen until you do so!"
    exit 1
fi

if [ "${INFLUXDB_PASSWORD}" = "changeMePlease" ]; then
    echo "Please specify InfluxDB's database users' password."
    echo "Nothing is gonna happen until you do so!"
    exit 1
fi

if [ "${INFLUXDB_ROOT_PASSWORD}" = "changeMePlease" ]; then
    echo "Please specify InfluxDB root's password."
    echo "Nothing is gonna happen until you do so!"
    exit 1
fi

if [ "${HTTP_PASSWORD}" = "changeMePlease" ]; then
    echo "Please specify an HTTP password for login to the dashboard."
    echo "Nothing is gonna happen until you do so!"
    exit 1
fi

# data only docker
sudo docker pull anduin/log_data
sudo docker run --name log_data --hostname log_data \
    -v /mnt/elasticsearch/data:/mnt/elasticsearch/data anduin/log_data
sleep 30

sudo docker pull anduin/influxdb_data
sudo rm -rf /mnt/influxdb
sudo mkdir /mnt/influxdb
sudo docker run --name influxdb_data --hostname influxdb_data \
    -v /mnt/influxdb:/mnt anduin/influxdb_data
sleep 30

# ElasticSearch Kibana
sudo docker pull anduin/es_kibana
sudo docker run --name es_kibana --hostname es_kibana \
    --volumes-from log_data \
    -p 8080:80 -p 9200:9200 -d anduin/es_kibana
sudo docker start es_kibana
sleep 30

ESK_ADDR=`sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' es_kibana`
curl -XPUT http://${ESK_ADDR}:9200/_template/logstash -d@es_kibana/config/kibana/template.json

# InfluxDB and Grafana
sudo docker pull anduin/grafana-influxdb
sudo docker run -d -v /etc/localtime:/etc/localtime:ro \
    -p 8081:80 -p 8083:8083 -p 8084:8084 -p 8086:8086 \
    -e INFLUXDB_ADDR=${INFLUXDB_ADDR} \
    -e INFLUXDB_DATA_PW=${INFLUXDB_PASSWORD} \
    -e CADVISOR_PW=${INFLUXDB_PASSWORD} \
    -e INFLUXDB_GRAFANA_PW=${INFLUXDB_PASSWORD} \
    -e ROOT_PW=${INFLUXDB_ROOT_PASSWORD} \
    --volumes-from influxdb_data \
    --hostname grafana-influxdb \
    --name grafana-influxdb anduin/grafana-influxdb
sudo docker start grafana-influxdb
sleep 30

# Fluentd
sudo docker pull anduin/fluentd
sudo docker run --name=fluentd --hostname fluentd \
    -p 42185:42185/udp \
    --link es_kibana:esk --link grafana-influxdb:ixdb -d \
    anduin/fluentd
#       -v /var/lib/docker/containers:/var/lib/docker/containers \
#       -v /var/log/docker:/var/log/docker \
sudo docker start fluentd
sleep 30

# Reverse proxy nginx
sudo docker pull anduin/nginx_proxy
sudo docker run -d -p 80:80 \
    --link es_kibana:es_kibana --link grafana-influxdb:grafana-influxdb \
    --hostname nginx_proxy \
    -e HTTP_USER=${HTTP_USER} -e HTTP_PASSWORD=${HTTP_PASSWORD} \
    --name nginx_proxy anduin/nginx_proxy
sudo docker start nginx_proxy
