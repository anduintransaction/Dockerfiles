FROM nginx:1.11.8

MAINTAINER ductamnguyen@anduintransact.com

# Install golang

ADD 'https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz' /tmp
RUN cd /tmp && tar xzf go1.8.linux-amd64.tar.gz && \
    mv go /usr/local/go && \
    rm go1.8.linux-amd64.tar.gz

ENV GOPATH /opt/go
ENV PATH /usr/local/go/bin:$GOPATH/bin:$PATH

RUN mkdir -p $GOPATH/src/simple-proxy
COPY . $GOPATH/src/simple-proxy
WORKDIR $GOPATH/src/simple-proxy

RUN ./build.sh

ENTRYPOINT ["./run.sh"]
