#!/usr/bin/env bash

if [ "x$USE_CONSUL" == "xtrue" ]; then
    echo "{{key \"$CONSUL_KEY\"}}" > /tmp/app.tmpl
    echo "Connect to $CONSUL_ENDPOINT"
    echo "Waiting for consul."
    until $(curl --output /dev/null --silent --head --fail http://$CONSUL_ENDPOINT/v1/agent/self); do
        printf "."
        sleep 1
    done
    echo "done"
    rm -f $SYNC_GATEWAY_CONFIG_FILE
    consul-template -consul $CONSUL_ENDPOINT \
                    -template "/tmp/app.tmpl:$SYNC_GATEWAY_CONFIG_FILE" \
                    -exec "/opt/run-sync-gateway.sh"
else
    /opt/run-sync-gateway.sh
fi
