#!/usr/bin/env bash

export TASK_MANAGER_HEAP_SIZE=${TASK_MANAGER_HEAP_SIZE:-1024}
export NUMBER_OF_TASK_SLOTS=${NUMBER_OF_TASK_SLOTS:-4}
export STATE_BACKEND_FS_CHECKPOINT_DIR=${STATE_BACKEND_FS_CHECKPOINT_DIR:-hdfs://flink/checkpoint}
export FS_HDFS_HADOOPCONF=${FS_HDFS_HADOOPCONF:-/opt/flink/hadoop-conf/default}
export HA_ZOOKEEPER_QUORUM=${HA_ZOOKEEPER_QUORUM:-zookeeper:2181}
export HA_STORAGE_DIR=${HA_STORAGE_DIR:-hdfs://flink/ha}

flinkConfigFile=/opt/flink/conf/flink-conf.yaml
envsubst < $flinkConfigFile > /tmp/flink-conf.yaml
mv /tmp/flink-conf.yaml $flinkConfigFile

exec /opt/flink/bin/taskmanager.sh start-foreground

