FROM phusion/passenger-full:0.9.18
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get -o Dpkg::Options::="--force-confnew" upgrade -y && apt-get -o Dpkg::Options::="--force-confnew" install -y \
    git \
    build-essential \
    g++ \
    flex \
    bison \
    gperf \
    ruby \
    perl \
    libsqlite3-dev \
    libfontconfig1-dev \
    libicu-dev \
    libfreetype6 \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    python \
    libx11-dev \
    libxext-dev

RUN mkdir /tmp/phantomjs \
    && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
           | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && cd /tmp/phantomjs \
    && mv bin/phantomjs /usr/local/bin

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
