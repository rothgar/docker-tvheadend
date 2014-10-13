FROM ubuntu:14.04
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>

# Install repos and packages
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y curl software-properties-common python-software-properties
RUN curl http://apt.tvheadend.org/repo.gpg.key | sudo apt-key add -
RUN echo "deb http://apt.tvheadend.org/stable trusty main" > /etc/apt/sources.list.d/tvheadend.list
# RUN apt-add-repository http://apt.tvheadend.org/stable
RUN apt-add-repository ppa:tfylliv/dvbhdhomerun
RUN apt-get update
RUN apt-get install -y hdhomerun-config dvbhdhomerun-dkms dvbhdhomerun-utilsh
RUN apt-get install -y tvheadend

# Configure HDHomeRun
# discover and config hdhomerun
RUN echo "["$(hdhomerun_config discover | cut -d ' ' -f 3)"]" > /etc/dvbhdhomerun
RUN echo "tuner_type=ATSC" >> /etc/dvbhdhomerun
RUN service tvheadend restart

EXPOSE 9981 9982
