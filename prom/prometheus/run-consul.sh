#!/usr/bin/env bash

echo "{{key \"$CONSUL_KEY\"}}" > /tmp/app.tmpl
echo "{{key \"$CONSUL_RULE_KEY\"}}" > /tmp/rules.tmpl
echo "Connect to $CONSUL_ENDPOINT"
printf "Waiting for consul."
until $(curl --output /dev/null --silent --head --fail http://$CONSUL_ENDPOINT/v1/agent/self); do
    printf "."        
    sleep 1 
done
echo "done"

rm -f $CONSUL_APP_CONFIG
consul-template -consul $CONSUL_ENDPOINT \
                -template "/tmp/app.tmpl:$CONSUL_APP_CONFIG" \
                -template "/tmp/rules.tmpl:/etc/prometheus.rules" \
                -exec "supervisord -c /etc/supervisord.conf"
