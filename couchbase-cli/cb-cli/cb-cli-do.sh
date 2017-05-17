#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "USAGE: $0 [action] ..."
    exit 1
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

action=$1
shift

/opt/couchbase/bin/couchbase-cli $action \
                                 -c $COUCHBASE_HOST:8091 -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD \
                                 $@
