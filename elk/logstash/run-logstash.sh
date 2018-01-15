#!/usr/bin/env bash

if [ -z "$LOGSTASH_CONFIG_FILE" ]; then
    LOGSTASH_CONFIG_FILE=/opt/logstash/default-logstash.conf
fi

if [ -z "$LOGSTASH_HEAP_SIZE" ]; then
    LOGSTASH_HEAP_SIZE=128m
fi

sed -i 's/-Xms1g/-Xms'$LOGSTASH_HEAP_SIZE'/' /opt/logstash/config/jvm.options
sed -i 's/-Xmx1g/-Xmx'$LOGSTASH_HEAP_SIZE'/' /opt/logstash/config/jvm.options

exec /opt/logstash/bin/logstash -f $LOGSTASH_CONFIG_FILE
