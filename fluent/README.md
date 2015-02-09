Fluent
=========

Docker image for Fluent - ElasticSearch - Kibana.  In this setup, Fluent is a waiting for rsyslog and Docker log inputs.

## Build image
`sudo docker build -t log_server .`

## Run instance
`sudo docker run -p 8080:80 -p 9200:9200 -p 42185:42185 -d \
    -v /var/lib/docker/containers:/var/lib/docker/containers \
    -v /var/log/docker:/var/log/docker log_server`

## Access Kibana:
`http://server_adress:8080`
