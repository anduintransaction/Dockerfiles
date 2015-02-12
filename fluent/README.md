Fluent
=========

Docker image for Fluentd.  In this setup, Fluent is a waiting for rsyslog and Docker log inputs.

## Build image
`sudo docker build -t anduin/fluentd .`

## Run instance
(Remember to start an es_kibana container before this step)
`sudo docker run --name=fluentd -p 42185:42185/udp \
       --link es_kibana:esk -d \
       -v /var/lib/docker/containers:/var/lib/docker/containers \
       -v /var/log/docker:/var/log/docker \
       anduin/fluentd`
