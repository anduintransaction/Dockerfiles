#!/usr/bin/env bash

if [ $# -gt 0 ] && [ "x$1" != "xprometheus" ]; then
    exec $@
fi

if [ $# -gt 0 ] && [ "x$1" == "xprometheus" ]; then
    shift
fi
export EXTRA_ARGS=$@

/run.sh
