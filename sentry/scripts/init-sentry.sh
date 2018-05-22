#!/usr/bin/env bash

function checkEnv {
    if [ -z "${SENTRY_SYSTEM_SECRET_KEY}" ]; then
        echo "SENTRY_SYSTEM_SECRET_KEY must be set"
        return 1
    fi

    if [ -z "${SENTRY_REDIS_HOST}" ]; then
        echo "SENTRY_REDIS_HOST must be set"
        return 1
    fi

    if [ -z "${SENTRY_REDIS_PORT}" ]; then
        echo "SENTRY_REDIS_PORT must be set"
        return 1
    fi

    if [ -z "${SENTRY_DB_HOST}" ]; then
        echo "SENTRY_DB_HOST must be set"
        return 1
    fi

    if [ -z "${SENTRY_DB_PORT}" ]; then
        echo "SENTRY_DB_PORT must be set"
        return 1
    fi

    if [ -z "${SENTRY_DB_NAME}" ]; then
        echo "SENTRY_DB_NAME must be set"
        return 1
    fi

    if [ -z "${SENTRY_DB_USER}" ]; then
        echo "SENTRY_DB_USER must be set"
        return 1
    fi

    if [ -z "${SENTRY_DB_PASSWORD}" ]; then
        echo "SENTRY_DB_PASSWORD must be set"
        return 1
    fi

    if [ -z "${SENTRY_INITIAL_USERNAME}" ]; then
        echo "SENTRY_INITIAL_USERNAME must be set"
        return 1
    fi

    if [ -z "${SENTRY_INITIAL_PASSWORD}" ]; then
        echo "SENTRY_INITIAL_PASSWORD must be set"
        return 1
    fi
}

function doUpgradeDatabase {
    echo "Upgrading database"
    SENTRY_CONF=/etc/sentry sentry upgrade --noinput --no-repair &&
        redis-cli -h $SENTRY_REDIS_HOST -p $SENTRY_REDIS_PORT set sentry_init_upgraded "1"
}

function upgradeDatabase {
    echo "Checking database should be upgraded or not"
    if [ "$SENTRY_FORCE_UPGRADE" == "true" ] || [ "$SENTRY_FORCE_UPGRADE" == "1" ]; then
        echo "Force update"
        doUpgradeDatabase
    else
        key="sentry_init_upgraded"
        upgradeValue=`redis-cli -h $SENTRY_REDIS_HOST -p $SENTRY_REDIS_PORT get $key`
        if [ $? -ne 0 ]; then
            return 1
        fi
        if [[ "$upgradeValue" = WRONGTYPE* ]]; then
            echo "Wrong type for key $key"
            return 1
        elif [ "$upgradeValue" == "1" ]; then
            echo "Skipping upgrade database"
        else
            doUpgradeDatabase
        fi
    fi
}

function doCreateUser {
    echo "Creating initial user '$SENTRY_INITIAL_USERNAME' with password '${SENTRY_INITIAL_PASSWORD:0:4}****'"
    SENTRY_CONF=/etc/sentry sentry createuser --email $SENTRY_INITIAL_USERNAME --password $SENTRY_INITIAL_PASSWORD --superuser &&
        redis-cli -h $SENTRY_REDIS_HOST -p $SENTRY_REDIS_PORT set sentry_init_user_created "1"
}

function createUser {
    echo "Checking if we should create the initial user"
    if [ "$SENTRY_FORCE_CREATE_USER" == "true" ] || [ "$SENTRY_FORCE_CREATE_USER" == "1" ]; then
        echo "Force create"
        doCreateUser
    else
        key="sentry_init_user_created"
        value=`redis-cli -h $SENTRY_REDIS_HOST -p $SENTRY_REDIS_PORT get $key`
        if [ $? -ne 0 ]; then
            return 1
        fi
        if [[ "$value" = WRONGTYPE* ]]; then
            echo "Wrong type for key $key"
            return 1
        elif [ "$value" == "1" ]; then
            echo "Skipping create initial user"
        else
            doCreateUser
        fi
    fi
}

if ! checkEnv; then
    exit 1
fi

export SENTRY_MAIL_BACKEND=${SENTRY_MAIL_BACKEND:-dummy}
export SENTRY_MAIL_HOST=${SENTRY_MAIL_HOST:-localhost}
export SENTRY_MAIL_PORT=${SENTRY_MAIL_PORT:-25}
export SENTRY_MAIL_TLS=${SENTRY_MAIL_TLS:-false}
export SENTRY_MAIL_ENABLE_REPLIES=${SENTRY_MAIL_ENABLE_REPLIES:-false}
export SENTRY_FILESTORE_BACKEND=${SENTRY_FILESTORE_BACKEND:-filesystem}
export SENTRY_FILESTORE_LOCATION=${SENTRY_FILESTORE_LOCATION:-/tmp/sentry-files}
export SENTRY_SINGLE_ORGANIZATION=${SENTRY_SINGLE_ORGANIZATION:-True}
export SENTRY_DEBUG=${SENTRY_DEBUG:-False}
export SENTRY_SESSION_COOKIE_SECURE=${SENTRY_SESSION_COOKIE_SECURE:-True}
export SENTRY_CSRF_COOKIE_SECURE=${SENTRY_CSRF_COOKIE_SECURE:-True}

envsubst < /etc/sentry/config.yml > /etc/sentry/config.yml
envsubst < /etc/sentry/sentry.conf.py > /etc/sentry/sentry.conf.py

upgradeDatabase && createUser
