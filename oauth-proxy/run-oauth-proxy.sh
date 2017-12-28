#!/usr/bin/env bash

if [ -z "$OAUTH_PROXY_CONFIG_FILE" ]; then
    echo "OAUTH_PROXY_CONFIG_FILE must be set"
    exit 1
fi

exec /opt/oauth-proxy :8765 $OAUTH_PROXY_CONFIG_FILE
