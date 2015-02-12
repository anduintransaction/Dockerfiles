#!/bin/bash
sudo docker run --name es_kibana \
    --volumes-from log_data \
    -p 8080:80 -p 9200:9200 -d anduin/es_kibana
