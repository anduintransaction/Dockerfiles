#!/bin/sh

if [ $# -gt 0 ]; then
    exec $@
fi

if [ -z "$CADDYFILE" ]; then
    exec /go/bin/caddy
else
    exec /go/bin/caddy -conf $CADDYFILE
fi
