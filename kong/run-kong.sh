#!/usr/bin/env bash

function _quit {
    echo "Killing $childPid"
    kill $childPid
    /usr/local/bin/kong stop
}

trap _quit SIGTERM

/usr/local/bin/kong start --nginx-conf /etc/custom_nginx.template &
childPid=$!
echo "Waiting $childPid"
wait "$childPid"
