#!/usr/bin/env bash

if [ $# -lt 2 ]; then
    echo "USAGE: $0 [bucket name] [bucket ramsize]"
    exit 1
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

bucketName=$1
bucketRamsize=$2

echo "Creating bucket $bucketName"
if cb-cli-do.sh bucket-list | grep -q "^$bucketName$"; then
    echo "Bucket $bucketName existed"
    exit 0
fi

cb-cli-do.sh bucket-create \
             --bucket=$bucketName \
             --bucket-type=couchbase \
             --bucket-ramsize=$bucketRamsize\
             --enable-flush=1 \
             --wait
