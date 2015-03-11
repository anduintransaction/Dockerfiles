FROM	ubuntu:14.04
MAINTAINER cuongpham@anduintransact.com

# Prevent some error messages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install

# ---------------- #
#   Installation   #
# ---------------- #

# Install all prerequisites
RUN apt-get -y install wget nginx supervisor curl apache2-utils

# ----------------- #
#   Configuration   #
# ----------------- #

# These two variable must be overwritten at 'docker run'
ENV HTTP_USER anduin
ENV HTTP_PASSWORD passw0rd

# Configure nginx and supervisord
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./setup_nginx.sh /setup_nginx.sh
RUN chmod +x /setup_nginx.sh

# ----------- #
#   Cleanup   #
# ----------- #

RUN apt-get autoremove -y wget && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/*

# ---------------- #
#   Expose Ports   #
# ---------------- #

EXPOSE 8090

# -------- #
#   Run   #
# -------- #

CMD ["/usr/bin/supervisord"]
