FROM anduin/flink-base:1.4.0
MAINTAINER ductamnguyen@anduintransact.com

ADD ./config/flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ADD ./config/hadoop-conf /opt/flink/hadoop-conf
ADD services/run-jobmanager.sh /etc/service/jobmanager/run

EXPOSE 6123 6124 8081

CMD ["/sbin/my_init"]
