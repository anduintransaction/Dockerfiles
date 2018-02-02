FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

ARG ELASTICSEARCH_VERSION=6.1.3

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.sha512 && \
    tar -xzf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
    mv elasticsearch-${ELASTICSEARCH_VERSION} /opt/elasticsearch && \
    rm elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.sha512 && \
    groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g elasticsearch -M

COPY config /opt/config
COPY run-elasticsearch.sh /etc/service/elasticsearch/run

VOLUME /opt/es-data
EXPOSE 9200

CMD ["/sbin/my_init"]
