FROM anduin/java
MAINTAINER Cuong Pham "cuongpham@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

# install apache webserver
RUN apt-get update
RUN apt-get install -y supervisor curl wget

# install ElasticSearch
RUN \
    curl -s http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
    if ! grep "elasticsearch" /etc/apt/sources.list; then echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list;fi && \
    apt-get update

RUN \
    apt-get install -y elasticsearch && \
    apt-get clean && \
    sed -i '/#cluster.name:.*/a cluster.name: logstash' /etc/elasticsearch/elasticsearch.yml && \
    sed -i '/#path.data: \/path\/to\/data/a path.data: /mnt/elasticsearch/data' /etc/elasticsearch/elasticsearch.yml

ADD config/etc/supervisor/conf.d/elasticsearch.conf /etc/supervisor/conf.d/elasticsearch.conf

# install Kibana
RUN \
    curl -s https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-linux-x64.tar.gz | tar -C /opt -xz && \
    ln -s /opt/kibana-4.0.0-linux-x64 /opt/kibana && \
    sed -i 's/port: 5601/port: 80/' /opt/kibana/config/kibana.yml

ADD config/etc/supervisor/conf.d/kibana.conf /etc/supervisor/conf.d/kibana.conf
# ADD config/kibana/default.json /var/www/site/app/dashboards/default.json

# 8080:80       -- Kibana
# 9200:9200     -- ElasticSearch - Link to fluentd
EXPOSE 80 9200

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]
