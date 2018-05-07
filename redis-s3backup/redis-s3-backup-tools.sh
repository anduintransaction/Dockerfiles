#!/usr/bin/env bash

function checkEnv {
    envName=$1
    envValue=${!envName}
    if [ -z "$envValue" ]; then
        echo "$envName is not defined"
        return 1
    fi
}

function checkAllEnv {
    checkEnv AWS_ACCESS_KEY_ID &&
        checkEnv AWS_SECRET_ACCESS_KEY &&
        checkEnv AWS_DEFAULT_REGION &&
        checkEnv REDIS_HOST &&
        checkEnv REDIS_PORT
}

function doBackup {
    if [ $# -lt 1 ]; then
        echo "USAGE: $0 backup [s3 bucket]"
        exit 1
    fi
    s3Bucket=$1
    echo "Backing up to $s3Bucket"
    redis-dump -h $REDIS_HOST -p $REDIS_PORT > backup.redis &&
        tar czf backup.redis.tar.gz backup.redis &&
        aws s3 cp backup.redis.tar.gz s3://$s3Bucket &&
        echo "Done"
}

function doRestore {
    if [ $# -lt 1 ]; then
        echo "USAGE: $0 restore [s3 bucket]"
        exit 1
    fi
    s3Bucket=$1
    echo "Restoring from $s3Bucket"
    aws s3 cp s3://$s3Bucket backup.redis.tar.gz &&
        tar xzf backup.redis.tar.gz &&
        echo FLUSHDB | redis-cli -h $REDIS_HOST -p $REDIS_PORT &&
        redis-cli -h $REDIS_HOST -p $REDIS_PORT < backup.redis &&
        rm backup.redis backup.redis.tar.gz &&
        echo "Done"
}

if ! checkAllEnv; then
    exit 1
fi

if [ $# -lt 1 ]; then
    exec /bin/bash
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
