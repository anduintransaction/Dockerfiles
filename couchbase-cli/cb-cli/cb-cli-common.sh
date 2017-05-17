#!/usr/bin/env bash

function readCommonEnv {
    if [ -z "$COUCHBASE_HOST" ]; then
        export COUCHBASE_HOST=localhost
    else
        export COUCHBASE_HOST=`echo $COUCHBASE_HOST | sed 's!^http://!!'`
    fi

    if [ -z "$COUCHBASE_USERNAME" ]; then
        export COUCHBASE_USERNAME=Administrator
    fi

    if [ -z "$COUCHBASE_PASSWORD" ]; then
        export COUCHBASE_PASSWORD=password
    fi
}
