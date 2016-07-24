#!/usr/bin/env bash

while true; do
    /usr/local/bin/sync_gateway /opt/anduin/couchbase/config.json
    if [ $? -ne 0 ]; then
        echo "Restarting..."
        sleep 3
    else
        break
    fi
done
