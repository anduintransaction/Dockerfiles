#!/usr/bin/env bash

echo "{{key \"$CONSUL_KEY\"}}" > /tmp/elasticsearch.yml.tmpl
echo "Connect to $CONSUL_ENDPOINT"
printf "Waiting for consul."
until $(curl --output /dev/null --silent --head --fail http://$CONSUL_ENDPOINT/v1/agent/self); do
    printf "."
    sleep 1
done
echo "done"

consul-template -consul $CONSUL_ENDPOINT -template "/tmp/elasticsearch.yml.tmpl:/etc/elasticsearch/elasticsearch.yml:/etc/init.d/elasticsearch restart"
