#!/usr/bin/env bash

function _quit {
    echo "Killing $childPid"
    kill $childPid
}

trap _quit SIGTERM

/opt/prometheus/prometheus \
    -config.file=/etc/prometheus.yml \
    -storage.local.path=/data/prometheus \
    -web.console.libraries=/opt/prometheus/console_libraries \
    -web.console.templates=/opt/prometheus/consoles \
    $EXTRA_ARGS &

childPid=$!
echo "Waiting $childPid"
wait "$childPid"
