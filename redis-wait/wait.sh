#!/usr/bin/env bash

REDIS_HOST=${REDIS_HOST:-127.0.0.1}
REDIS_PORT=${REDIS_PORT:-6379}

echo "Connecting to $REDIS_HOST:$REDIS_PORT"
count=0
while ! redis-cli -h $REDIS_HOST -p $REDIS_PORT PING > /dev/null 2>&1; do
    count=`expr $count + 1`
    echo "Tried $count time(s)"
    if [ "$count" -ge 5 ]; then
        echo "Failed"
        exit 1
    fi
    sleep 3
done
echo Done
