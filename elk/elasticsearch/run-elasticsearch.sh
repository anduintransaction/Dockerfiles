#!/usr/bin/env bash

export ES_PATH_CONF=/opt/config
if [ -z "$ES_JAVA_OPTS" ]; then
    export ES_JAVA_OPTS="-Xms1g -Xmx1g"
fi
if [ -z "$ES_CLUSTER_NAME" ]; then
    export ES_CLUSTER_NAME="es"
fi
if [ -z "$ES_NODE_NAME" ]; then
    export ES_NODE_NAME="es-1"
fi
if [ ! -z "$ES_SINGLE_MODE" ]; then
    ES_FLAGS="-E discovery.type=single-node"
fi

chown -R elasticsearch:elasticsearch $ES_PATH_CONF
chown elasticsearch:elasticsearch /opt/es-data

exec /sbin/setuser elasticsearch /opt/elasticsearch/bin/elasticsearch $ES_FLAGS
