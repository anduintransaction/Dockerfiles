#!/usr/bin/env bash

function checkEnv {
    if [ -z "$KEYCLOAK_ADMIN_USER" ]; then
        export KEYCLOAK_ADMIN_USER=admin
        echo "Using default keycloak admin user: $KEYCLOAK_ADMIN_USER"
    else
        echo "Using keycloak admin user: $KEYCLOAK_ADMIN_USER"
    fi
    if [ -z "$KEYCLOAK_ADMIN_PASSWORD" ]; then
        export KEYCLOAK_ADMIN_PASSWORD=admin
        echo "Using default keycloak admin password: $KEYCLOAK_ADMIN_PASSWORD"
    else
        echo "Using keycloak admin password: ${KEYCLOAK_ADMIN_PASSWORD:0:4}******"
    fi
    if [ -z "$KEYCLOAK_POSTGRES_HOST" ]; then
        export KEYCLOAK_POSTGRES_HOST="postgres"
        echo "Using default postgres host: $KEYCLOAK_POSTGRES_HOST"
    else
        echo "Using postgres host: $KEYCLOAK_POSTGRES_HOST"
    fi
    if [ -z "$KEYCLOAK_POSTGRES_PORT" ]; then
        export KEYCLOAK_POSTGRES_PORT="5432"
        echo "Using default postgres port: $KEYCLOAK_POSTGRES_PORT"
    else
        echo "Using postgres port: $KEYCLOAK_POSTGRES_PORT"
    fi
    if [ -z "$KEYCLOAK_POSTGRES_USER" ]; then
        export KEYCLOAK_POSTGRES_USER="keycloak"
        echo "Using default postgres user: $KEYCLOAK_POSTGRES_USER"
    else
        echo "Using postgres user: $KEYCLOAK_POSTGRES_USER"
    fi
    if [ -z "$KEYCLOAK_POSTGRES_PASSWORD" ]; then
        export KEYCLOAK_POSTGRES_PASSWORD="keycloak"
        echo "Using default postgres password: $KEYCLOAK_POSTGRES_PASSWORD"
    else
        echo "Using postgres password: ${KEYCLOAK_POSTGRES_PASSWORD:0:4}******"
    fi
    if [ -z "$KEYCLOAK_POSTGRES_DATABASE" ]; then
        export KEYCLOAK_POSTGRES_DATABASE="keycloak"
        echo "Using default postgres database: $KEYCLOAK_POSTGRES_DATABASE"
    else
        echo "Using postgres database: $KEYCLOAK_POSTGRES_DATABASE"
    fi
}

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

if [ $1 != "server" ]; then
    exec $@
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
checkEnv

$here/add-user-keycloak.sh --user $KEYCLOAK_ADMIN_USER --password $KEYCLOAK_ADMIN_PASSWORD &&
    exec $here/standalone.sh -Dfile.encoding=UTF-8 -b 0.0.0.0 --server-config standalone.xml
