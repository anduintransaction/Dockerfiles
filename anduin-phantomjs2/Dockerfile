FROM phusion/passenger-full:0.9.18
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get  -o Dpkg::Options::="--force-confnew" upgrade -y && apt-get -o Dpkg::Options::="--force-confnew" install -y \
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

ENV PHANTOM_JS_TAG 2.1.1

RUN git clone https://github.com/ariya/phantomjs.git /tmp/phantomjs && \
  cd /tmp/phantomjs && git checkout $PHANTOM_JS_TAG && \
  ./build.sh --confirm && mv bin/phantomjs /usr/local/bin && \
  rm -rf /tmp/phantomjs

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
