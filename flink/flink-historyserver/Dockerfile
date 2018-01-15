FROM anduin/flink-base:1.4.0
MAINTAINER ductamnguyen@anduintransact.com

ADD ./config/flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ADD ./config/hadoop-conf /opt/flink/hadoop-conf
ADD ./services/run-historyserver.sh /etc/service/historyserver/run

EXPOSE 8082

CMD ["/sbin/my_init"]
