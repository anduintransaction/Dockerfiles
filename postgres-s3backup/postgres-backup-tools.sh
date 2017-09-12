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
        checkEnv PGHOST &&
        checkEnv PGUSER &&
        checkEnv PGPASSWORD &&
        checkEnv PGDATABASE
}

function doBackup {
    if [ $# -lt 1 ]; then
        echo "USAGE: $0 backup [s3 bucket]"
        exit 1
    fi
    s3Bucket=$1
    echo "Backing up to $s3Bucket"
    pg_dump $PGDATABASE --clean > backup.sql &&
        tar czf backup.sql.tar.gz backup.sql &&
        aws s3 cp backup.sql.tar.gz s3://$s3Bucket &&
        rm backup.sql backup.sql.tar.gz &&
        echo "Done"
}

function doRestore {
    if [ $# -lt 1 ]; then
        echo "USAGE: $0 restore [s3 bucket]"
        exit 1
    fi
    s3Bucket=$1
    echo "Restoring from $s3Bucket"
    aws s3 cp s3://$s3Bucket backup.sql.tar.gz &&
        tar xzf backup.sql.tar.gz &&
        psql $PGDATABASE < backup.sql &&
        rm backup.sql backup.sql.tar.gz &&
        echo "Done"
}

checkAllEnv
if [ $? -ne 0 ]; then
    exit 1
fi

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

cmd=$1
shift

echo "Using PGHOST=$PGHOST"
echo "Using PGUSER=$PGUSER"
echo "Using PGPASSWORD=${PGPASSWORD:0:4}****"
echo "Using PGDATABASE=$PGDATABASE"

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
