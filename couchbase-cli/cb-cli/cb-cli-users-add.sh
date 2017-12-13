#!/usr/bin/env bash

if [ $# -lt 3 ]; then
    echo "USAGE: $0 [username] [password] [roles]"
    exit 1
fi

here=`cd $(dirname $BASH_SOURCE); pwd`
. $here/cb-cli-common.sh

readCommonEnv

username=$1
password=$2
roles=$3

echo "Adding user $username with roles $roles"

couchbase-cli user-manage -c $COUCHBASE_HOST -u $COUCHBASE_USERNAME -p $COUCHBASE_PASSWORD --set --rbac-username $username --rbac-password $password --roles $roles --auth-domain local
