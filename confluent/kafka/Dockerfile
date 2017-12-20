FROM anduin/confluent-base:1.0
MAINTAINER ductamnguyen@anduintransact.com

RUN mkdir -p /opt/kafka && mkdir -p /etc/service/kafka
ADD kafka.properties /opt/kafka/kafka.properties
ADD run-kafka.sh /etc/service/kafka/run
RUN chmod +x /etc/service/kafka/run

VOLUME /data

CMD ["/sbin/my_init"]
