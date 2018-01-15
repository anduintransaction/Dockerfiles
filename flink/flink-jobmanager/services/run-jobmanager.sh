#!/usr/bin/env bash

export JOB_MANAGER_RPC_ADDRESS=`hostname -f`
export JOB_MANAGER_HEAP_SIZE=${JOB_MANAGER_HEAP_SIZE:-1024}
export JOB_MANAGER_ARCHIVE_FS_DIR=${JOB_MANAGER_ARCHIVE_FS_DIR:-hdfs://flink/archive}
export HISTORY_SERVER_ARCHIVE_FS_DIR=${HISTORY_SERVER_ARCHIVE_FS_DIR:-hdfs://flink/archive}
export STATE_BACKEND_FS_CHECKPOINT_DIR=${STATE_BACKEND_FS_CHECKPOINT_DIR:-hdfs://flink/checkpoint}
export FS_HDFS_HADOOPCONF=${FS_HDFS_HADOOPCONF:-/opt/flink/hadoop-conf/default}
export HA_STORAGE_DIR=${HA_STORAGE_DIR:-hdfs://flink/ha}
export HA_ZOOKEEPER_QUORUM=${HA_ZOOKEEPER_QUORUM:-zookeeper:2181}

flinkConfigFile=/opt/flink/conf/flink-conf.yaml
envsubst < $flinkConfigFile > /tmp/flink-conf.yaml
mv /tmp/flink-conf.yaml $flinkConfigFile

exec /opt/flink/bin/jobmanager.sh start-foreground cluster $JOB_MANAGER_RPC_ADDRESS
