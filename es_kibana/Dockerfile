FROM anduin/java
MAINTAINER Cuong Pham "cuongpham@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

# install apache webserver
RUN apt-get update && apt-get install -yq \
    build-essential \
    make \
    apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

ADD config/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# install ElasticSearch
RUN cd /opt; \
      curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.0.RC2.tar.gz; \
      tar zxvf elasticsearch-0.90.0.RC2.tar.gz; \
      mv elasticsearch-0.90.0.RC2 elasticsearch; \
      rm -f elasticsearch-0.90.0.RC2.tar.gz

# install Kibana
RUN cd /tmp; \
      curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0milestone5.tar.gz; \
      tar zxvf kibana-3.0.0milestone5.tar.gz; \
      mv kibana-3.0.0milestone5 kibana; \
      mv kibana /var/www/site


# 8080:80       -- apache server
# 9200:9200     -- ElasticSearch - Link to fluentd
EXPOSE 80 9200

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/supervisord.conf /etc/supervisor/supervisord.conf
ADD config/kibana/config.js /var/www/site/config.js
ADD config/kibana/default.json /var/www/site/app/dashboards/default.json

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
