# Anduin common image

FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

# install essential tools
RUN apt-get update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    ca-certificates \
    software-properties-common \
    python-software-properties \
    python-pip \
    curl \
    wget \
    git \
    --no-install-recommends

# Install JDK 8
RUN wget --quiet \
    --output-document=/jdk-8.tar.gz \
    --no-check-certificate \
    --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_144
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_144
ENV PATH $JAVA_HOME/bin:$PATH

# Unlimited strength
RUN apt-get install unzip && wget --quiet --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip jce_policy-8.zip && \
    mkdir -p $JAVA_HOME/jre/lib/security && \
    cp UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/jre/lib/security && \
    rm -rf jce_policy-8.zip UnlimitedJCEPolicyJDK8

# Force Docker to use UTF-8 encodings
ENV LANG en_US.UTF-8

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
