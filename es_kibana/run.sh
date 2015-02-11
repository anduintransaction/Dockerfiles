#!/bin/bash
sudo docker run --name es_kibana -p 8080:80 -p 9200:9200 -d anduin/es_kibana
