FROM centos:centos7

MAINTAINER ductamnguyen@anduintransact.com

ENV PATH $PATH:/opt/couchbase-sync-gateway/bin

# Install dependencies:
#  wget: for downloading Sync Gateway package installer
RUN yum -y update && \
    yum install -y \
    wget python-setuptools epel-release && \
    easy_install supervisor

# Install Sync Gateway
RUN wget http://packages.couchbase.com/releases/couchbase-sync-gateway/1.3.0/couchbase-sync-gateway-community_1.3.0-274_x86_64.rpm && \
    rpm -i couchbase-sync-gateway-community_1.3.0-274_x86_64.rpm && \
    rm couchbase-sync-gateway-community_1.3.0-274_x86_64.rpm

RUN mkdir -p /opt/couchbase-sync-gateway/data && mkdir -p /opt/anduin/sync_gateway

##### nginx
# Install
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx
RUN rm -rf /etc/nginx
ADD ./config/nginx /etc/nginx

##### supervisor
# Configure
RUN rm -rf /etc/supervisor && mkdir -p /opt/supervisord/logs
ADD ./config/supervisord /etc/supervisor

COPY start_sync_gateway.sh /opt/anduin/sync_gateway/
COPY run_sync_gateway.sh /opt/anduin/sync_gateway/

# Install fixed version of sync gateway
RUN wget https://github.com/anduintransaction/sync_gateway/releases/download/1.3-anduin-v1/sync_gateway-1.3.1-anduin-linux-amd64.tar.gz && \
    tar xvzf sync_gateway-1.3.1-anduin-linux-amd64.tar.gz && \
    mv sync_gateway /opt/couchbase-sync-gateway/bin

CMD ["/opt/anduin/sync_gateway/start_sync_gateway.sh"]

EXPOSE 4984 4985
