#!/usr/bin/env bash

echo "{{key \"$CONSUL_KEY\"}}" > /tmp/td-agent.conf.tmpl
echo "Connect to $CONSUL_ENDPOINT"
printf "Waiting for consul."
until $(curl --output /dev/null --silent --head --fail http://$CONSUL_ENDPOINT/v1/agent/self); do
    printf "."
    sleep 1
done
echo "done"

consul-template -consul $CONSUL_ENDPOINT -template "/tmp/td-agent.conf.tmpl:/etc/td-agent/td-agent.conf:/etc/init.d/td-agent restart"
