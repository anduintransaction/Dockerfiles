#!/usr/bin/env bash

echo "{{key \"$CONSUL_KEY\"}}" > /tmp/app.tmpl
echo "{{key \"$CONSUL_NGINX_TEMPLATE_KEY\"}}" > /tmp/nginx.tmpl
echo "Connect to $CONSUL_ENDPOINT"
printf "Waiting for consul."
until $(curl --output /dev/null --silent --head --fail http://$CONSUL_ENDPOINT/v1/agent/self); do
    printf "."        
    sleep 1 
done
echo "done"

rm -f $CONSUL_APP_CONFIG
rm -f /opt/kibana/installedPlugins/logtrail/logtrail.json
consul-template -consul $CONSUL_ENDPOINT \
                -template "/tmp/app.tmpl:$CONSUL_APP_CONFIG" \
                -template "/tmp/nginx.tmpl:/etc/custom_nginx.template" \
                -exec "supervisord -c /etc/supervisord.conf"
