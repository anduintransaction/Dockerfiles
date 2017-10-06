#!/usr/bin/env bash

if [ -z "$VAULT_FOLDER" ]; then
    exec docker-entrypoint.sh $@
else
    echo "Using vault"
    exec vault-kube $VAULT_FOLDER docker-entrypoint.sh $@
fi
