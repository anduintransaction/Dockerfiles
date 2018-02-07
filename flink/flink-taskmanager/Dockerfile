FROM anduin/flink-base:1.4.0
MAINTAINER ductamnguyen@anduintransact.com

ADD ./config/flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ADD ./config/hadoop-conf /opt/flink/hadoop-conf
ADD services/run-taskmanager.sh /etc/service/taskmanager/run

CMD ["/sbin/my_init"]
