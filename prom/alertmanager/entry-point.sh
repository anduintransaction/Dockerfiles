#!/usr/bin/env bash

if [ $# -gt 0 ] && [ "x$1" != "xalertmanager" ]; then
    exec $@
fi

if [ $# -gt 0 ] && [ "x$1" == "xalertmanager" ]; then
    shift
fi
export EXTRA_ARGS=$@

/run-consul.sh
