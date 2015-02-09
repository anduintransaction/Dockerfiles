FROM ubuntu:14.10
MAINTAINER Cuong Pham  "cuongpham@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update && apt-get install -yq \
    build-essential \
    make \
    ca-certificates \
    net-tools \
    sudo \
    wget \
    vim \
    strace \
    lsof \
    netcat \
    software-properties-common \
    python-software-properties \
    python-pip \
    curl \
    supervisor \
    --no-install-recommends

# add repos and update:
RUN add-apt-repository ppa:webupd8team/java; apt-get update;

# install java8:
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections; apt-get -y install oracle-java8-installer oracle-java8-set-default --no-install-recommends

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# secured SecureRandom
RUN sed -e 's%^\(securerandom.source\)=.*%\1=file:/dev/./urandom%' \
        -i $JAVA_HOME/jre/lib/security/java.security

# install apache webserver
RUN apt-get -y install apache2

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

ADD config/kibana/config.js /var/www/site/config.js

# install fluent
RUN cd /tmp; \
      curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -; \
      echo "deb [arch=amd64] http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib" > /etc/apt/sources.list.d/treasure-data.list; \
      apt-get update; \
      apt-get install -y --force-yes td-agent libcurl4-gnutls-dev; \
      /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch; \
      /usr/sbin/td-agent-gem install fluent-plugin-record-reformer

ADD config/td-agent.conf /etc/td-agent/td-agent.conf

# 8080:80       -- apache server
# 9200:9200     -- ElasticSearch
# 42185:42185   -- fluent port for rsyslog
EXPOSE 4001 7001 80 9200 42185

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/supervisord.conf /etc/supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
