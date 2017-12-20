#!/usr/bin/env bash

KAFKA_REST_CONF_DIR=/opt/kafka-rest
KAFKA_REST_CONF_FILE=$KAFKA_REST_CONF_DIR/kafka-rest.properties

function readEnv {
    if [ -z "$KAFKA_HOST" ]; then
        echo "KAFKA_HOST not found"
        exit 1
    fi

    if [ -z "$KAFKA_PORT" ]; then
        echo "KAFKA_PORT not found"
        exit 1
    fi

    if [ -z "$KAFKA_CONSUMER_ID" ]; then
        KAFKA_CONSUMER_ID=kafka-rest-proxy
    fi

    if [ -z "$KAFKA_HEAP_OPTS" ]; then
        export KAFKA_HEAP_OPTS="-Xms128m -Xmx128m"
    fi
}

function writeConfig {
    mkdir -p $KAFKA_REST_CONF_DIR &&
        rm -f $KAFKA_REST_CONF_FILE &&
        echo "id=$KAFKA_CONSUMER_ID" >> $KAFKA_REST_CONF_FILE &&
        echo "bootstrap.servers=PLAINTEXT://$KAFKA_HOST:$KAFKA_PORT" >> $KAFKA_REST_CONF_FILE
}

readEnv && writeConfig && /opt/confluent/bin/kafka-rest-start $KAFKA_REST_CONF_FILE
