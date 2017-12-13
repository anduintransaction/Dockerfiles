#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "USAGE: $0 [username]"
    exit 1
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

username=$1

echo "Deleting user $username"

if `couchbase-cli user-manage -c $COUCHBASE_HOST -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD --list | jq .[].id -r | grep -q $username`; then
    couchbase-cli user-manage -c $COUCHBASE_HOST -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD --delete --rbac-username $username --auth-domain local
fi
