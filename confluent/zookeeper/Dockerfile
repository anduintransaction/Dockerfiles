FROM anduin/confluent-base:1.0
MAINTAINER ductamnguyen@anduintransact.com

RUN mkdir -p /opt/zkScripts && mkdir -p /etc/service/zookeeper
ADD zkGenConfig.sh zkOk.sh /opt/zkScripts/
ADD ./run-zookeeper.sh /etc/service/zookeeper/run
RUN chmod +x /etc/service/zookeeper/run

VOLUME /data

CMD ["/sbin/my_init"]
