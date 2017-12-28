FROM phusion/baseimage:0.9.22
MAINTAINER ductamnguyen@anduintransact.com

RUN apt-get update && \
    apt-get install -yq runit wget python-httplib2 chrpath \
    lsof lshw sysstat net-tools numactl  && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG CB_VERSION=5.0.1
ARG CB_RELEASE_URL=http://packages.couchbase.com/releases
ARG CB_PACKAGE=couchbase-server-community_5.0.1-ubuntu16.04_amd64.deb

ENV PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

RUN groupadd -g 1000 couchbase && useradd couchbase -u 1000 -g couchbase -M

RUN wget -N $CB_RELEASE_URL/$CB_VERSION/$CB_PACKAGE && \
    dpkg -i ./$CB_PACKAGE && rm -f ./$CB_PACKAGE

COPY scripts/run-couchbase.sh /etc/service/couchbase-server/run
COPY scripts/dummy.sh /usr/local/bin/
RUN ln -s dummy.sh /usr/local/bin/iptables-save && \
    ln -s dummy.sh /usr/local/bin/lvdisplay && \
    ln -s dummy.sh /usr/local/bin/vgdisplay && \
    ln -s dummy.sh /usr/local/bin/pvdisplay
RUN chrpath -r '$ORIGIN/../lib' /opt/couchbase/bin/curl

EXPOSE 8091 8092 8093 8094 11207 11210 11211 18091 18092 18093 18094
VOLUME /opt/couchbase/var

CMD ["/sbin/my_init"]
