#!/usr/bin/env bash

while true; do
    /opt/couchbase-sync-gateway/bin/sync_gateway /opt/anduin/couchbase/config.json
    if [ $? -ne 0 ]; then
        echo "Restarting..."
        sleep 3
    else
        break
    fi
done
