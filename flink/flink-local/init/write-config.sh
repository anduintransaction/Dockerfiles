#!/usr/bin/env bash

if [ "$USE_PUBLIC_IP" == "true" ]; then
    export JOB_MANAGER_RPC_ADDRESS=`hostname -I`
else
    export JOB_MANAGER_RPC_ADDRESS=localhost
fi

export JOB_MANAGER_HEAP_SIZE=${JOB_MANAGER_HEAP_SIZE:-512}
export NUMBER_OF_TASK_SLOTS=${NUMBER_OF_TASK_SLOTS:-4}

flinkConfigFile=/opt/flink/conf/flink-conf.yaml
envsubst < $flinkConfigFile > /tmp/flink-conf.yaml
mv /tmp/flink-conf.yaml $flinkConfigFile
