#!/usr/bin/env bash

if [ $# -lt 3 ]; then
    echo "USAGE: $0 [bucket name] [view name] [view file]"
    exit 1
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

bucketName=$1
viewName=$2
viewContent=`python $here/cb-cli-view-gen.py $viewName $3`

if [ $? -ne 0 ]; then
    exit 1
fi

echo "Creating view $viewName in $bucketName"
curl -X DELETE -sS -u $COUCHBASE_USERNAME:$COUCHBASE_PASSWORD $COUCHBASE_HOST:8092/$bucketName/_design/$viewName
for i in `seq 1 10`; do
    resp=`curl -v -sS -X PUT -u $COUCHBASE_USERNAME:$COUCHBASE_PASSWORD -H "Content-Type: application/json" -d "$viewContent" $COUCHBASE_HOST:8092/$bucketName/_design/$viewName 2>&1`
    if echo "$resp" | grep -q '"ok":true'; then
        echo "SUCCESS"
        exit 0
    fi
    echo .
    sleep 2
done
echo "FAILED"
exit 1
