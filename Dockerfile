FROM ubuntu:14.04
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>

# Install repos and packages
# RUN apt-get -y upgrade

# Install software and repos
RUN apt-get update && apt-get install -m -y git curl software-properties-common python-software-properties debconf-utils\
    dpkg-dev cmake dkms linux-headers-$(uname -r) build-essential module-assistant supervisor
RUN apt-get install -y hdhomerun-config libhdhomerun-dev debhelper
RUN curl http://apt.tvheadend.org/repo.gpg.key | sudo apt-key add -
RUN echo "deb http://apt.tvheadend.org/stable trusty main" > /etc/apt/sources.list.d/tvheadend.list

RUN apt-add-repository http://apt.tvheadend.org/stable
RUN cd /usr/src && git clone https://github.com/h0tw1r3/dvbhdhomerun; \
    cd /usr/src/dvbhdhomerun && dpkg-buildpackage; \
    cd /usr/src; dpkg -i dvbhdhomerun-*.deb
RUN apt-get update && apt-get install -y tvheadend

# Ports for Tvheadend service/web
EXPOSE 9981 9982

COPY start-hts.sh /scripts/start-hts.sh

CMD ["/scripts/start-hts.sh"]
