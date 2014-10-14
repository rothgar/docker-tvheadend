FROM ubuntu:14.04
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>

# Install repos and packages
RUN apt-get update
RUN apt-get -y upgrade

# Install software and repos
RUN apt-get install -y git curl software-properties-common python-software-properties
RUN apt-get install -y dpkg-dev cmake dkms linux-headers-$(uname -r) build-essential module-assistant
RUN apt-get install -y hdhomerun-config libhdhomerun-dev debhelper
RUN curl http://apt.tvheadend.org/repo.gpg.key | sudo apt-key add -
RUN echo "deb http://apt.tvheadend.org/stable trusty main" > /etc/apt/sources.list.d/tvheadend.list

RUN apt-add-repository http://apt.tvheadend.org/stable
RUN apt-get update
# RUN apt-get install -y dvbhdhomerun-dkms dvbhdhomerun-utilsh
RUN cd /usr/src; git clone https://github.com/h0tw1r3/dvbhdhomerun
RUN cd /usr/src/dvbhdhomerun && dpkg-buildpackage -b
RUN cd /usr/src && dpkg -i dvbhdhomerun-*.deb
RUN apt-get install -y tvheadend

# Configure HDHomeRun
# discover and config hdhomerun
RUN echo "["$(hdhomerun_config discover | cut -d ' ' -f 3)"]" > /etc/dvbhdhomerun
RUN echo "tuner_type=ATSC" >> /etc/dvbhdhomerun
RUN service tvheadend restart

EXPOSE 9981 9982
