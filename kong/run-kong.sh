#!/usr/bin/env bash

function _quit {
    echo "Killing $childPid"
    kill $childPid
    /usr/local/bin/kong stop
}

trap _quit SIGTERM

/usr/local/bin/kong start &
childPid=$!
echo "Waiting $childPid"
wait "$childPid"
