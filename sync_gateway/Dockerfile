FROM centos:centos7

MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

ENV GOPATH /opt/go
ENV SGROOT /opt/anduin/sync_gateway
ENV GOROOT /usr/local/go
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin

# Get dependencies
RUN yum -y update && \
    yum groupinstall -y development && \
    yum install -y \
    bc \
    curl \
    emacs-nox \
    git \
    mercurial \
    wget \
    epel-release \
    iproute \
    python-setuptools \
    hostname \
    inotify-tools \
    yum-utils which && \
    yum clean all && \
    easy_install supervisor

# Download and install Go
RUN wget http://golang.org/dl/go1.6.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.6.2.linux-amd64.tar.gz && \
    rm go1.6.2.linux-amd64.tar.gz

# install common go packages
RUN go get github.com/tools/godep && \
    go get github.com/nsf/gocode && \
    go get golang.org/x/tools/cmd/goimports && \
    go get github.com/golang/lint/golint && \
    go get github.com/rogpeppe/godef

# Build Sync Gateway
RUN mkdir -p $GOPATH && \
    mkdir -p /opt/anduin && \
    mkdir -p /opt/supervisord/logs && \
    cd /opt/anduin && \ 
    git clone https://github.com/couchbase/sync_gateway.git && \
    cd $SGROOT && \
    git checkout 1.2.1 && \	
    git submodule update --init --recursive && \
    ./build.sh && \
    cp bin/sync_gateway /usr/local/bin && \
    find . | grep .git | xargs rm -rf && \
    mkdir -p $SGROOT/data

##### supervisor
# Configure
RUN rm -rf /etc/supervisor
ADD ./config/supervisord /etc/supervisor

VOLUME ["/opt/supervisord"]

RUN groupadd -g 1000 couchbase && useradd couchbase -u 1000 -g couchbase -M

# Expose ports
EXPOSE 4984 4985

COPY start_sync_gateway.sh /opt/anduin/sync_gateway/

CMD ["/opt/anduin/sync_gateway/start_sync_gateway.sh"]