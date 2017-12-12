#!/usr/bin/env bash

function alreadyInit {
    httpCode=`curl --output /dev/null --silent --head --write-out '%{http_code}\n' http://$COUCHBASE_HOST:8091/pools/default`
    if [ "$httpCode" == "200" ] || [ "$httpCode" == "401" ]; then
        echo "Couchbase server at $COUCHBASE_HOST:8091 was already initialized"
        return 0
    fi
    return 1
}

function initCluster {
    curl -sS -X POST -o /dev/null $COUCHBASE_HOST:8091/pools/default \
         -d "memoryQuota=$COUCHBASE_MEMORY_QUOTA" \
         -d "indexMemoryQuota=$COUCHBASE_INDEX_MEMORY_QUOTA" \
         -d "ftsMemoryQuota=$COUCHBASE_INDEX_MEMORY_QUOTA" &&
        curl -sS -X POST -o /dev/null $COUCHBASE_HOST:8091/node/controller/setupServices -d "services=kv,index,n1ql,fts" &&
        curl -sS -X POST -o /dev/null $COUCHBASE_HOST:8091/settings/indexes -d "storageMode=forestdb" &&
        curl -sS -X POST -o /dev/null $COUCHBASE_HOST:8091/settings/web \
             -u Administrator:password \
             -d "username=$COUCHBASE_USERNAME" \
             -d "password=$COUCHBASE_PASSWORD" \
             -d "port=SAME"
}

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

COUCHBASE_INIT_SERVICES=data,index,query,fts
if [ -z "$COUCHBASE_MEMORY_QUOTA" ]; then
    COUCHBASE_MEMORY_QUOTA=1024
fi

if [ -z "$COUCHBASE_INDEX_MEMORY_QUOTA" ]; then
    COUCHBASE_INDEX_MEMORY_QUOTA=256
fi

echo "COUCHBASE_HOST: $COUCHBASE_HOST:8091"
echo "COUCHBASE_USERNAME: $COUCHBASE_USERNAME"
echo "COUCHBASE_PASSWORD: ${COUCHBASE_PASSWORD:0:4}******"
echo "COUCHBASE_MEMORY_QUOTA: $COUCHBASE_MEMORY_QUOTA"
echo "COUCHBASE_INDEX_MEMORY_QUOTA: $COUCHBASE_INDEX_MEMORY_QUOTA"

if ! $here/cb-cli-check-connect.sh; then
    exit 1
fi
if alreadyInit; then
    exit 0
fi
/opt/couchbase/bin/couchbase-cli node-init \
                                 -c $COUCHBASE_HOST:8091 -u Administrator -p password \
                                 --node-init-data-path=/opt/couchbase/var/lib/couchbase/data \
                                 --node-init-index-path=/opt/couchbase/var/lib/couchbase/data &&
    initCluster
