FROM phusion/passenger-full:0.9.17
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialog from apt:
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
    libicu52 \
    --no-install-recommends

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://github.com/Pyppe/phantomjs2.0-ubuntu14.04x64/raw/master/bin/phantomjs /usr/bin

RUN chmod +x /usr/bin/phantomjs

# add repos and update:
RUN add-apt-repository ppa:webupd8team/java; apt-get update

# install java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections; apt-get -y install oracle-java8-installer oracle-java8-set-default --no-install-recommends

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# secured SecureRandom
RUN sed -e 's%^\(securerandom.source\)=.*%\1=file:/dev/./urandom%' \
        -i $JAVA_HOME/jre/lib/security/java.security

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
