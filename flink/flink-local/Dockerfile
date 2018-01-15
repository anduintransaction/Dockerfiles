FROM anduin/flink-base:1.4.0
MAINTAINER ductamnguyen@anduintransact.com

ADD config/flink-conf.yaml /opt/flink/conf/flink-conf.yaml
ADD init/write-config.sh /etc/my_init.d/write-config.sh
ADD services/run-jobmanager.sh /etc/service/jobmanager/run
ADD services/run-historyserver.sh /etc/service/historyserver/run

VOLUME /data

EXPOSE 6123 6124 6125 8081 8082

CMD ["/sbin/my_init"]
