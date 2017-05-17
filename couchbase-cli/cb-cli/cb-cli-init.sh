#!/usr/bin/env bash

function alreadyInit {
    httpCode=`curl --output /dev/null --silent --head --write-out '%{http_code}\n' http://$COUCHBASE_HOST:8091/pools/default`
    if [ "$httpCode" == "200" ]; then
        echo "Couchbase server at $COUCHBASE_HOST:8091 was already initialized"
        return 0
    fi
    return 1
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
    /opt/couchbase/bin/couchbase-cli cluster-init \
                                     -c $COUCHBASE_HOST:8091 -u Administrator -p password \
                                     --cluster-username=$COUCHBASE_USERNAME \
                                     --cluster-password=$COUCHBASE_PASSWORD \
                                     --cluster-port=8091 \
                                     --services=$COUCHBASE_INIT_SERVICES \
                                     --cluster-ramsize=$COUCHBASE_MEMORY_QUOTA \
                                     --cluster-index-ramsize=$COUCHBASE_INDEX_MEMORY_QUOTA                                     
