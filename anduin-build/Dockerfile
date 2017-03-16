FROM anduin/anduin-phantomjs2:0.6.0
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

# avoid interactive dialog from apt:
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r anduin && useradd -g anduin anduin

# install essential tools
RUN rm /etc/apt/sources.list.d/redis.list && apt-get update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    ca-certificates \
    software-properties-common \
    python-software-properties \
    python-pip \
    curl \
    wget \
    supervisor \
    git \
    libfontconfig \
    libicu52 \
    --no-install-recommends

# Install JDK 8
RUN wget --quiet \
         --output-document=/jdk-8.tar.gz \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# Update ruby
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN /bin/bash -l -c "curl -L get.rvm.io | bash -s stable"
RUN /bin/bash -l -c "rvm install 2.1"
ENV PATH /usr/local/rvm/rubies/ruby-2.1.10/bin:$PATH
RUN /bin/bash -l -c "echo 'gem: --no-ri --no-rdoc' > ~/.gemrc"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Libreoffice
RUN apt-get install -y unoconv

# Fonts
RUN echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get update && apt-get install -y ttf-mscorefonts-installer

RUN wget 'http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe' && \
    cabextract -L -F ppviewer.cab -d . PowerPointViewer.exe && \
    mkdir /usr/share/fonts/vista && \
    cabextract -L -F '*.TT[FC]' -d /usr/share/fonts/vista ppviewer.cab && \
    fc-cache -fv /usr/share/fonts/vista && \
    rm PowerPointViewer.exe ppviewer.cab

ADD fonts/* /usr/share/fonts/truetype/msttcorefonts/
RUN fc-cache -f

# set the environment variables
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_121
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_121
ENV PATH $JAVA_HOME/bin:$PATH

# Unlimited strength
RUN apt-get install unzip && wget --quiet --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
    unzip jce_policy-8.zip && \
    mkdir -p $JAVA_HOME/lib/security && \
    cp UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/lib/security && \
    rm -rf jce_policy-8.zip UnlimitedJCEPolicyJDK8

# Force Docker to use UTF-8 encodings
ENV LANG en_US.UTF-8

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
