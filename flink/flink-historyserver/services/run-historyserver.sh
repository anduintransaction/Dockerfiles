#!/usr/bin/env bash

export HISTORY_SERVER_ARCHIVE_FS_DIR=${HISTORY_SERVER_ARCHIVE_FS_DIR:-hdfs://flink/archive}
export FS_HDFS_HADOOPCONF=${FS_HDFS_HADOOPCONF:-/opt/flink/hadoop-conf/default}

flinkConfigFile=/opt/flink/conf/flink-conf.yaml
envsubst < $flinkConfigFile > /tmp/flink-conf.yaml
mv /tmp/flink-conf.yaml $flinkConfigFile

exec /opt/flink/bin/historyserver-foreground.sh
