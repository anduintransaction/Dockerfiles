#!/usr/bin/env bash

echo "Using env:"
echo "PGHOST=$PGHOST"
echo "PGUSER=$PGUSER"
echo "PGPASSWORD=${PGPASSWORD:0:4}****"
export PGCONNECT_TIMEOUT=10

count=0
until psql -c 'SELECT 1' > /dev/null; do
    echo .
    count=`expr $count + 1`
    if [ $count -gt 10 ]; then
        echo "Unable to connect to postgres server"
        exit 1
    fi
    sleep 5
done
echo "Done"
