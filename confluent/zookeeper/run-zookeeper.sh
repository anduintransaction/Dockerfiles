#!/usr/bin/env bash

/opt/zkScripts/zkGenConfig.sh && /opt/confluent/bin/zookeeper-server-start /opt/zookeeper/conf/zoo.cfg
