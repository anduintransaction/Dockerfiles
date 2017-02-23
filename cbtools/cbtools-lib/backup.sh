#!/usr/bin/env bash

function backupCmd {
    if [ $# -lt 2 ]; then
        echo "USAGE: cbtools backup <couchbase_host:couchbase_port> <s3_folder>"
        exit 1
    fi
    couchbase=$1
    s3Folder=$2
    folderName=`basename $s3Folder`
    rm -rf /tmp/couchbase-backup/$folderName
    mkdir -p /tmp/couchbase-backup
    now=`date`
    /opt/couchbase/bin/cbbackup http://$couchbase /tmp/couchbase-backup/$folderName -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD && \
        echo "Back up at $now for $couchbase" > /tmp/couchbase-backup/$folderName/backup-info.txt && \
        aws s3 rm --recursive s3://$s3Folder && \
        aws s3 cp --recursive /tmp/couchbase-backup/$folderName s3://$s3Folder        
}
