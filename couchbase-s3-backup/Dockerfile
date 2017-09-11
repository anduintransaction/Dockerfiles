FROM ubuntu:14.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

# Couchbase
RUN apt-get update && \
    apt-get install -yq runit wget python-httplib2 chrpath \
    lsof lshw sysstat net-tools numactl

ENV CB_VERSION=4.5.1 \
    CB_RELEASE_URL=http://packages.couchbase.com/releases \
    CB_PACKAGE=couchbase-server-community_4.5.1-ubuntu14.04_amd64.deb

RUN wget -N $CB_RELEASE_URL/$CB_VERSION/$CB_PACKAGE && \
    dpkg -i ./$CB_PACKAGE && rm -f ./$CB_PACKAGE

# AWS
RUN apt-get -y install python-pip && \
    pip install awscli

# Other tools
RUN apt-get install -y curl

RUN apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install cbtools
ADD couchbase-backup-tools.sh /

ENTRYPOINT ["/couchbase-backup-tools.sh"]
