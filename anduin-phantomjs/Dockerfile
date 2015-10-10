FROM phusion/passenger-full:0.9.17
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

RUN apt-get update && apt-get install -y \
    curl libfreetype6 libfontconfig bzip2

ENV PHANTOMJS_VERSION 1.9.8

RUN curl -SLO "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" \
	&& tar -xjf "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2" -C /usr/local --strip-components=1 \
	&& rm "phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
