FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get install -y nodejs

# Libreoffice
RUN apt-get install python-software-properties && apt-add-repository -y ppa:libreoffice/ppa && apt-get update && apt-get install -y unoconv

# Fonts
RUN echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list.d/multiverse.list && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get update && apt-get install -y ttf-mscorefonts-installer

RUN wget 'https://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe' && \
    cabextract -L -F ppviewer.cab -d . PowerPointViewer.exe && \
    mkdir /usr/share/fonts/vista && \
    cabextract -L -F '*.TT[FC]' -d /usr/share/fonts/vista ppviewer.cab && \
    fc-cache -fv /usr/share/fonts/vista && \
    rm PowerPointViewer.exe ppviewer.cab

ADD fonts/* /usr/share/fonts/truetype/msttcorefonts/
RUN fc-cache -f

# Carbone CLI
RUN npm install -g carbone-cli@1.0.1

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
