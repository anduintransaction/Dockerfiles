sudo docker run --name=fluentd -p 42185:42185/udp \
       --link es_kibana:esk -d \
       -v /var/lib/docker/containers:/var/lib/docker/containers \
       -v /var/log/docker:/var/log/docker \
       anduin/fluentd