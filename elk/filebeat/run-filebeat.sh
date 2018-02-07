#!/usr/bin/env bash

if [ -z "$FILEBEAT_CONFIG_FILE" ]; then
    FILEBEAT_CONFIG_FILE=/opt/filebeat/default-filebeat.yml
    echo "Using default filebeat config file. Dont do this."
fi

if [ -z "$FILEBEAT_DATA_PATH" ]; then
    FILEBEAT_DATA_PATH=/tmp/filebeat
    echo "Using tmp data path. Dont do this"
fi

/opt/filebeat/filebeat -e -c $FILEBEAT_CONFIG_FILE --path.data $FILEBEAT_DATA_PATH
