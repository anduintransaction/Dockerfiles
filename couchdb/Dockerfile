# Based on https://github.com/klaemo/docker-couchdb
FROM debian:wheezy
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

# Repositories
RUN echo 'deb http://http.debian.net/debian wheezy-backports main' > /etc/apt/sources.list.d/wheezy-backports.list
RUN apt-get update -q

# Install prereqs
RUN apt-get update && apt-get --no-install-recommends -y install \
  build-essential \
  ca-certificates \
  curl \
  erlang-base-hipe \
  erlang-dev \
  erlang-nox \
  git \
  libicu-dev \
  nodejs \
  libmozjs185-dev
RUN apt-get --no-install-recommends -y install \
  erlang-reltool

# Build rebar
RUN useradd -m rebar
USER rebar
WORKDIR /home/rebar
RUN curl -L https://github.com/rebar/rebar/archive/2.5.0.tar.gz | tar zxf -
WORKDIR /home/rebar/rebar-2.5.0
RUN ./bootstrap
USER root
RUN cp rebar /usr/local/bin/
RUN chmod 755 /usr/local/bin/rebar
RUN userdel rebar
RUN rm -rf /home/rebar

# Build couchdb
RUN useradd -m couchdb
USER couchdb
WORKDIR /home/couchdb
RUN git clone http://git-wip-us.apache.org/repos/asf/couchdb.git couchdb.git
# RUN git clone https://github.com/apache/couchdb.git couchdb.git
WORKDIR couchdb.git
RUN git checkout -b build master
# Expose nodes on external network interface
RUN sed -i'' 's/bind_address = 127.0.0.1/bind_address = 0.0.0.0/' rel/overlay/etc/default.ini
# Build
RUN ./configure -p /opt/couchdb
RUN make

# Install
USER root
RUN mkdir -p /opt/couchdb
RUN chown -R couchdb.couchdb /opt/couchdb
RUN npm install -g grunt-cli
USER couchdb
RUN make install
RUN git log > /opt/couchdb/.git.log

# Cleanup source
WORKDIR ..
RUN rm -rf couchdb.git

# Cleanup
USER root
RUN apt-get purge -y \
  build-essential \
  curl \
  git \
  erlang-reltool
RUN apt-get autoremove -y

# Finalize
USER couchdb
RUN sed -i -e 's/^-name .*$/-name couchdb@server.local/' /opt/couchdb/etc/vm.args
EXPOSE 5984 5986
CMD ["/opt/couchdb/bin/couchdb","-d"]
