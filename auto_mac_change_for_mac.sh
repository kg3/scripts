#!/bin/bash
# found openssl from commandlinefu
mac=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'` 
sudo ifconfig en0 ether $mac
date=`date`
echo "Changed Mac at $date" >> macChange.log
sudo ifconfig en0 |grep ether >> macChange.log
sudo ifconfig en0 |grep ether
sleep 30

exit 0
