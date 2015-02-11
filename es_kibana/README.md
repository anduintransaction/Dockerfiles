Fluent
=========

Docker image for ElasticSearch - Kibana.  Link this an instance of this container to the fluentd container.

## Build image
`sudo docker build -t anduin/es_kibana .`

## Run instance
`sudo docker run --name es_kibana -p 8080:80 -d anduin/es_kibana `

## Access Kibana:
`http://server_adress:8080`
