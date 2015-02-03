FROM ubuntu:14.04
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>

# Install repos and packages
RUN apt-get update && apt-get -y upgrade

# Install software and repos
RUN apt-get install -m -y wget git curl make dkms dpkg-dev \
    debconf-utils software-properties-common linux-headers-$(uname -r) \
    build-essential hdhomerun-config libhdhomerun-dev debhelper libswscale-dev \
    libavahi-client-dev libavformat-dev libavcodec-dev liburiparser-dev \
    libssl-dev libiconv-hook1 libiconv-hook-dev

# checkout tvheadend
RUN git clone https://github.com/tvheadend/tvheadend.git /srv/tvheadend
WORKDIR /srv/tvheadend
RUN ./configure --enable-hdhomerun_static --enable-libffmpeg_static && make

CMD ["/srv/tvheadend/build.linux/tvheadend","-C"]
