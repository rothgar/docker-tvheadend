FROM ubuntu:14.04
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV HTS_COMMIT master

# Install repos and packages
RUN apt-get update && apt-get -y upgrade

# Install software and repos
RUN apt-get install -m -y wget git curl make dkms dpkg-dev \
    debconf-utils software-properties-common \
    build-essential hdhomerun-config libhdhomerun-dev debhelper libswscale-dev \
    libavahi-client-dev libavformat-dev libavcodec-dev liburiparser-dev \
    libssl-dev libiconv-hook1 libiconv-hook-dev

# checkout, build, and install tvheadend
RUN git clone https://github.com/tvheadend/tvheadend.git /srv/tvheadend \
  && cd /srv/tvheadend && git checkout ${HTS_COMMIT} && ./configure --libffmpeg_static && make && make install

# Clean up APT and temporary files
RUN rm -r /srv/tvheadend && apt-get purge -qq build-essential pkg-config git
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9981 9982

VOLUME /config /recordings /data

# add a user to run as non root
RUN adduser --disabled-password --gecos '' hts

CMD ["/usr/local/bin/tvheadend","-C","-u","hts","-g","hts","-c","/config"]
