Fluent
=========

Docker image for ElasticSearch - Kibana.  Link this an instance of this container to the fluentd container.

## Build image
`sudo docker build -t anduin/es_kibana .`

## Run instance
(We need to make sure that the log_data container exists)

`sudo docker run --name es_kibana \
    --volumes-from log_data \
    -p 8080:80 -p 9200:9200 -d anduin/es_kibana`

## Access Kibana:
`http://server_adress:8080`
