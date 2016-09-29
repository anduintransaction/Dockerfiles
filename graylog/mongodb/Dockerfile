FROM anduin/consul-template
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-get update && \
    apt-get install -y mongodb-org

RUN mkdir -p /data/db

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD mongod --bind_ip 0.0.0.0
