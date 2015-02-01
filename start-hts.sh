!#/bin/bash

# Configure HDHomeRun
# discover and config hdhomerun
echo "["$(hdhomerun_config discover | cut -d ' ' -f 3)"]" | sudo tee /etc/dvbhdhomerun
echo "tuner_type=ATSC" >> /etc/dvbhdhomerun

/usr/bin/tvheadend -u hts -g video -C
