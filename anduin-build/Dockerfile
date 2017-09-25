FROM anduin/anduin-app-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

RUN groupadd -r anduin && useradd -g anduin anduin

# Nodejs
ENV NODE_VERSION v6.10.0
RUN apt-get update && apt-get install xz-utils && \
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz && \
    tar -xJf node-${NODE_VERSION}-linux-x64.tar.xz -C /usr/local --strip-components=1 && \
    rm node-${NODE_VERSION}-linux-x64.tar.xz && \
    ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Ruby
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"
RUN /bin/bash -l -c "rvm install 2.1"
ENV PATH /usr/local/rvm/rubies/ruby-2.1.10/bin:$PATH
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install yarn

# PhantomJS
RUN apt-get install -y git build-essential g++ flex bison gperf perl libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev libpng-dev libjpeg-dev libx11-dev libxext-dev

RUN mkdir /tmp/phantomjs \
    && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && cd /tmp/phantomjs \
    && mv bin/phantomjs /usr/local/bin

ENV MJML_VERSION 3.3.3
RUN npm install -g mjml@${MJML_VERSION}

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

