#!/usr/bin/env bash

if [ -z "$VAULT_FOLDER" ]; then
    exec /opt/keycloak/bin/run-keycloak.sh $@
else
    echo "Using vault"
    exec vault-kube $VAULT_FOLDER /opt/keycloak/bin/run-keycloak.sh $@
fi
