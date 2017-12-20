FROM anduin/confluent-base:1.0
MAINTAINER ductamnguyen@anduintransact.com

RUN mkdir -p /etc/service/kafka-rest
ADD run-kafka-rest.sh /etc/service/kafka-rest/run
RUN chmod +x /etc/service/kafka-rest/run

CMD ["/sbin/my_init"]
