#!/usr/bin/env bash

function _quit {
    echo "Killing $childPid"
    kill $childPid
}

trap _quit SIGTERM

/opt/alertmanager \
    -config.file /opt/alertmanager.yml -storage.path /data/alertmanager \
    $EXTRA_ARGS &

childPid=$!
echo "Waiting $childPid"
wait "$childPid"
