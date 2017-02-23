#!/usr/bin/env bash

function restoreCmd {
    if [ $# -lt 3 ]; then
        echo "Usage: cbtools restore <couchbase_host:couchbase_port> <s3_folder> <bucket1,bucket2> [flags...]"
        exit 1
    fi
    couchbase=$1
    shift
    s3Folder=$1
    shift
    buckets=$1
    shift
    buckets=`echo $buckets | sed 's/,/ /'`
    # Restore
    rm -f /tmp/restore && mkdir -p /tmp/restore
    aws s3 sync s3://$s3Folder /tmp/restore
    if [ $? -ne 0 ]; then
        exit 1
    fi
    for bucket in $buckets; do
        echo "Restoring bucket $bucket"
        /opt/couchbase/bin/cbrestore /tmp/restore http://$couchbase -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD -b $bucket -B $bucket $@
        if [ $? -ne 0 ]; then
            exit 1
        fi
    done
}
