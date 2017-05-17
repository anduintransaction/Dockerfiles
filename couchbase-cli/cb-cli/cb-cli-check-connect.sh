#!/usr/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

url=http://$COUCHBASE_HOST:8091
echo "Checking couchbase connection to $url"
for i in `seq 1 30`; do
    if curl --output /dev/null --silent --head --fail --max-time 10 $url; then
        echo "SUCCESS"
        exit 0
    fi
    echo .
    sleep 5
done
echo "FAILED"
exit 1
