#!/usr/bin/env bash

count=0

while ! eval $WAIT_COMMAND ; do
    count=`expr $count + 1`
    echo "Tried $count time(s)"
    if [ "$count" -ge 50 ]; then
        echo "Failed"
        exit 1
    fi
    sleep 3
done
echo Done
