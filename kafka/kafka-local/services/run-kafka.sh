#!/usr/bin/env bash

echo "Checking connection to zookeeper"

until echo stat | nc localhost 2181 > /dev/null 2>&1; do
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

trap handleKafkaShutdown SIGTERM

if [ -z "$KAFKA_HEAP_OPTS" ]; then
    export KAFKA_HEAP_OPTS="-Xms256m -Xmx256m"
fi

if [ -z "$KAFKA_ADVERTISED_LISTENERS" ]; then
    ip=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
    KAFKA_ADVERTISED_LISTENERS=${ip}:9092
fi

if [ -z "$KAFKA_LOG_RETENTION_HOURS" ]; then
    KAFKA_LOG_RETENTION_HOURS=168
fi

if [ -z "$KAFKA_DEFAULT_NUM_PARTITIONS" ]; then
    KAFKA_DEFAULT_NUM_PARTITIONS=1
fi

if [ -z "$KAFKA_DEFAULT_REPLICATION_FACTOR" ]; then
    KAFKA_DEFAULT_REPLICATION_FACTOR=1
fi

/opt/kafka/bin/kafka-server-start.sh \
    /opt/configs/kafka.properties \
    --override advertised.listeners=PLAINTEXT://$KAFKA_ADVERTISED_LISTENERS \
    --override log.retention.hours=$KAFKA_LOG_RETENTION_HOURS \
    --override zookeeper.connection.timeout.ms=30000 \
    --override zookeeper.session.timeout.ms=30000 \
    --override num.partitions=$KAFKA_DEFAULT_NUM_PARTITIONS \
    --override default.replication.factor=$KAFKA_DEFAULT_REPLICATION_FACTOR &

kafkaPid=$!
wait $kafkaPid
