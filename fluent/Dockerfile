FROM anduin/base
MAINTAINER Cuong Pham "cuongpham@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

# install fluent
RUN apt-get update && \
    apt-get install -y --force-yes build-essential make

RUN cd /tmp; \
      curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -; \
      echo "deb [arch=amd64] http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib" > /etc/apt/sources.list.d/treasure-data.list; \
      apt-get update; \
      apt-get install -y --force-yes td-agent libcurl4-gnutls-dev; \
      /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch; \
      /usr/sbin/td-agent-gem install fluent-plugin-record-reformer

ADD config/td-agent.conf /etc/td-agent/td-agent.conf
ADD config/td-agent-influxdb.conf /etc/td-agent/td-agent-influxdb.conf

# RUN echo 'export ES_ADDR=$ESK_PORT_9200_TCP_ADDR' >> /etc/default/td-agent

# 42185:42185   -- fluent port for rsyslog
EXPOSE 42185/udp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
