#!/usr/bin/env bash

SYNC_GATEWAY_CONFIG_FILE=/opt/sync-gateway-config.json
PID=0

if [ ! -z "$COUCHBASE_HOST" ]; then
    COUCHBASE_URL="http://$COUCHBASE_HOST:8091"
    echo "Wait for couchbase at ${COUCHBASE_URL}"
    count=0
    until $(curl --output /dev/null --silent --head --fail -m 10 ${COUCHBASE_URL}); do
        echo '.'
        sleep 5
        count=`expr $count + 1`
        if [ $count -gt 20 ]; then
            echo "Something wrong when waiting for couchbase"
            exit 1
        fi
    done
    echo "done"
fi

function _quit {
    echo "Killing $PID FROM $$"
    KILLING=1        
    kill -0 $PID > /dev/null 2>&1 && kill $PID
    echo "Done killing FROM $$"
    exit 0
}

trap _quit SIGTERM

while true; do
    echo "Try to start FROM $$"
    if [ -f "$SYNC_GATEWAY_CONFIG_FILE" ]; then
        /opt/couchbase-sync-gateway/bin/sync_gateway $SYNC_GATEWAY_CONFIG_FILE &
    else
        /opt/couchbase-sync-gateway/bin/sync_gateway &
    fi
    PID=$!
    echo "waiting for $PID FROM $$"
    wait $PID
    echo "something wrong, restarting FROM $$"
    sleep 3
done
