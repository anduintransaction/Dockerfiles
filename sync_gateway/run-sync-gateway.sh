#!/usr/bin/env bash

SYNC_GATEWAY_CONFIG_FILE=/opt/sync-gateway-config.json
PID=0
KILLING=0

function _quit {
    if [ "$PID" -ne 0 ]; then
        echo "Killing $PID"
        KILLING=1
        kill $PID
    fi
}

trap _quit SIGTERM

while true; do
    if [ -f "$SYNC_GATEWAY_CONFIG_FILE" ]; then
        /opt/sync_gateway $SYNC_GATEWAY_CONFIG_FILE &
    else
        /opt/sync_gateway &
    fi
    PID=$!
    echo "waiting for $PID"
    wait $PID
    if [ $KILLING -ne 0 ]; then
        echo "got kill signal, exiting"
        break
    fi
    echo "something wrong, restarting"
    sleep 3
done
