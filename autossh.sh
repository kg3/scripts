#!/bin/bash
SERVERADDR=ser.ver.addr
USER=user
P=2222
CMD='screen -xrR'
ARG='-C'

#Kill autossh
killall -9 autossh

echo "NO FORWARDS"
autossh -M61000 -t $USER@$SERVERADDR -p $P $ARGS $CMD
#echo "FORWARDING VNC"
#autossh -M61000 -t $USER@$SERVERADDR -p $P $ARGS -L 5902:localhost:5902


exit 0
