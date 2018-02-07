#!/usr/bin/env bash

if [ "$USE_PUBLIC_IP" == "true" ]; then
    JOB_MANAGER_RPC_ADDRESS=`hostname -I`
else
    JOB_MANAGER_RPC_ADDRESS=localhost
fi

exec /opt/flink/bin/jobmanager.sh start-foreground local $JOB_MANAGER_RPC_ADDRESS
