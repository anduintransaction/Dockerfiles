#!/usr/bin/env bash

if [ -z "$ZOOKEEPER_HOST" ]; then
    echo "ZOOKEEPER_HOST not found"
    exit 1
fi

if [ -z "$ZOOKEEPER_PORT" ]; then
    echo "ZOOKEEPER_PORT not found"
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

/opt/confluent/bin/kafka-server-start \
    /opt/kafka/kafka.properties \
    --override broker.id=${HOSTNAME##*-} \
    --override zookeeper.connect=$ZOOKEEPER_HOST:$ZOOKEEPER_PORT \
    --override advertised.listeners=PLAINTEXT://:9092 \
    $@ &

kafkaPid=$!
wait $kafkaPid
