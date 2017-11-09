#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

if [ $1 != "server" ]; then
    exec $@
fi

if [ -z "$VAULT_FOLDER" ]; then
    exec /opt/keycloak/bin/run-keycloak.sh $@
else
    echo "Using vault"
    exec vault-kube $VAULT_FOLDER /opt/keycloak/bin/run-keycloak.sh $@
fi
