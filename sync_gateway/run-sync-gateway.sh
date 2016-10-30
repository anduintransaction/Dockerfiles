#!/usr/bin/env bash

SYNC_GATEWAY_CONFIG_FILE=/opt/sync-gateway-config.json
PID=0

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
        /opt/sync_gateway $SYNC_GATEWAY_CONFIG_FILE &
    else
        /opt/sync_gateway &
    fi
    PID=$!
    echo "waiting for $PID FROM $$"
    wait $PID
    echo "something wrong, restarting FROM $$"
    sleep 3
done
