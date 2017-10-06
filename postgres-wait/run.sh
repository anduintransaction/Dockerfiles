#!/usr/bin/env bash

if [ -z "$VAULT_FOLDER" ]; then
    exec /opt/wait.sh
else
    echo "Using vault"
    exec vault-kube $VAULT_FOLDER /opt/wait.sh
fi
