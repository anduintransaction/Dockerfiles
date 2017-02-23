#!/usr/bin/env bash

function runCommand {
    if [ -z "$AWS_ACCESS_KEY_ID" ]; then
        echo "AWS_ACCESS_KEY_ID must be set"
        exit 1
    fi
    if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        echo "AWS_SECRET_ACCESS_KEY must be set"
        exit 1
    fi
    if [ -z "$AWS_DEFAULT_REGION" ]; then
        echo "AWS_DEFAULT_REGION must be set"
        exit 1
    fi
    if [ -z "$COUCHBASE_USERNAME" ]; then
        export COUCHBASE_USERNAME=Administrator
    fi
    if [ -z "$COUCHBASE_PASSWORD" ]; then
        export COUCHBASE_PASSWORD=password
    fi
    cmd=$1
    shift
    case $cmd in
        backup)
            backupCmd $@
            ;;
        dailybackup)
            dailybackupCmd $@
            ;;
        restore)
            restoreCmd $@
            ;;
        *)
            echo "Unknown command"
            exit 1
            ;;
    esac
}

# Get today from trustable internet source
function getToday {
    if [ -z "$TODAY_INTERNET_SOURCES" ]; then
        TODAY_INTERNET_SOURCES="https://google.com https://facebook.com https://amazon.com"
    fi    
    for source in $TODAY_INTERNET_SOURCES; do
        dateFromHTTP=`curl -s -m 5 -D - $source -o /dev/null 2>/dev/null | grep Date | sed 's/^Date: //'`
        if [ -z "$dateFromHTTP" ]; then
            continue
        fi
        today=`date -d "$dateFromHTTP" "+%Y%m%d"` 2>/dev/null
        if [ ! -z "$today" ]; then
            echo $today
            return
        fi
    done
}
