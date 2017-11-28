#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    exec /bin/bash
fi

cmd=$1

if [ "$cmd" != "server" ]; then
    exec $@
fi

shift

if [ -z "$ZOOKEEPER_HOST" ]; then
    echo "ZOOKEEPER_HOST not found"
    exit 1
fi

if [ -z "$ZOOKEEPER_PORT" ]; then
    echo "ZOOKEEPER_PORT not found"
    exit 1
fi

if [ -z "$KAFKA_ADVERTISED_ADDRESS_SUFFIX" ]; then
    echo "KAFKA_ADVERTISED_ADDRESS_SUFFIX found"
    exit 1
fi

echo "Checking connection to zookeeper $ZOOKEEPER_HOST:$ZOOKEEPER_PORT"

until echo stat | nc $ZOOKEEPER_HOST $ZOOKEEPER_PORT > /dev/null 2>&1; do
    echo "Connecting..."
    sleep 3
done

function handleKafkaShutdown {
    echo "Shutting down kafka"
    kill $kafkaPid > /dev/null 2>&1
    for i in `seq 1 10`; do
        if kill -0 $kafkaPid > /dev/null 2>&1; then
            echo "..."
            sleep 1
        else
            return
        fi
    done
    kill -9 $kafkaPid > /dev/null 2>&1
}

trap handleKafkaShutdown SIGTERM SIGINT

if [ -z "$KAFKA_HEAP_OPTS" ]; then
    export KAFKA_HEAP_OPTS="-Xms256m -Xmx256m"
fi

KAFKA_ADVERTISED_LISTENERS=${HOSTNAME}.${KAFKA_ADVERTISED_ADDRESS_SUFFIX}:9092

/opt/kafka/bin/kafka-server-start.sh \
    /opt/configs/kafka.properties \
    --override zookeeper.connect=$ZOOKEEPER_HOST:$ZOOKEEPER_PORT \
    --override advertised.listeners=PLAINTEXT://$KAFKA_ADVERTISED_LISTENERS \
    $@ &

kafkaPid=$!
wait $kafkaPid
