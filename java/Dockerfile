FROM anduin/base:0.4.0
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialoges from apt:
ENV DEBIAN_FRONTEND noninteractive

# add repos and update:
RUN add-apt-repository ppa:webupd8team/java; apt-get update;

# install java 8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections; apt-get -y install oracle-java8-installer oracle-java8-set-default maven --no-install-recommends

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# secured SecureRandom
RUN sed -e 's%^\(securerandom.source\)=.*%\1=file:/dev/./urandom%' \
        -i $JAVA_HOME/jre/lib/security/java.security

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
