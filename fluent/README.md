Fluent
=========

Docker image for Fluent - ElasticSearch - Kibana.  In this basic setup, Fluent is a waiting for rsyslog inputs.

## Build image
`sudo docker build -t log_server .`

## Run instance
`sudo docker run -p 8080:80 -p 9200:9200 -p 42185:42185 -d log_server`

## Access Kibana:
`http://server_adress:8080`
