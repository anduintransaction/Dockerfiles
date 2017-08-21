#!/usr/bin/env bash

function checkEnv {
    if [ -z "$AWS_ACCESS_KEY_ID" ]; then
        echo "AWS_ACCESS_KEY_ID is not set"
        return 1
    fi
    if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        echo "AWS_SECRET_ACCESS_KEY is not set"
        return 1
    fi
    if [ -z "$AWS_DEFAULT_REGION" ]; then
        echo "AWS_DEFAULT_REGION is not set"
        exit 1
    fi
}

function doBackup {
    if [ $# -lt 2 ]; then
        echo "USAGE: backup [local folder] [bucket]"
        return 1
    fi
    localFolder=$1
    s3Bucket=$2
    echo "Backup to $s3Bucket"
    cp -r $localFolder /tmp/backup &&
        cd /tmp &&
        tar czf backup.tar.gz backup &&
        aws s3 cp backup.tar.gz s3://$s3Bucket &&
        echo "Done"
}

function doRestore {
    if [ $# -lt 2 ]; then
        echo "USAGE: restore [s3 bucket] [local folder]"
        return 1
    fi
    s3Bucket=$1
    localFolder=$2
    echo "Restoring from $s3Bucket"
    parent=`dirname $localFolder`
    aws s3 cp s3://$s3Bucket /tmp/backup.tar.gz &&
        cd /tmp &&
        tar xzf backup.tar.gz &&
        mkdir -p $parent &&
        rm -rf $localFolder &&
        mv backup $localFolder &&
        echo "Done"
}

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

if ! checkEnv; then
    exit 1
fi

cmd=$1
shift

case $cmd in
    backup)
        doBackup $@
        ;;
    restore)
        doRestore $@
        ;;
    *)
        exec $cmd $@
        ;;
esac
