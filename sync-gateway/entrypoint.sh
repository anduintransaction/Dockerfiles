#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

cmd=$1
case $cmd in
    server)
        configFile=$2
        if [ -z "$configFile" ]; then
            configFile="/opt/sync-gateway-config-default.json"
        fi
        exec /opt/couchbase-sync-gateway/bin/sync_gateway $configFile
        ;;
    *)
        exec $@
        ;;
esac
