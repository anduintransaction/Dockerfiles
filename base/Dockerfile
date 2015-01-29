FROM ubuntu:14.10
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r anduin && useradd -g anduin anduin

# install essential tools
RUN apt-get update && apt-get install -yq \
    ca-certificates \
    software-properties-common \
    python-software-properties \
    python-pip \
    curl \
    supervisor \
    git \
    libfontconfig \
    --no-install-recommends
    
# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
