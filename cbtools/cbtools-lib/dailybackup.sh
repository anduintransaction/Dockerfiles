#!/usr/bin/env bash

function dailybackupCmd {
    if [ $# -lt 2 ]; then
        echo "Usage: cbtools dailybackup <couchbase_host:couchbase_port> <s3_folder>"
        exit 1
    fi
    couchbase=$1
    s3Folder=$2
    today=`getToday`
    localFolder="/tmp/couchbase-daily-backup/$today"
    remoteFolder="$s3Folder/$today"
    now=`date`
    rm -rf $localFolder && mkdir -p $localFolder    
    aws s3 sync s3://$remoteFolder $localFolder && \
        /opt/couchbase/bin/cbbackup http://$couchbase $localFolder -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD -m accu && \
        echo "Back up at $now for $couchbase" >> $localFolder/daily-backup-info.txt && \
        aws s3 sync $localFolder s3://$remoteFolder
}
