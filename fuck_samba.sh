#!/bin/bash
# fuck samba
# http://serverfault.com/questions/294109/why-doesnt-sshfs-let-me-look-into-a-mounted-directory
# for mac
RUSER=user
SERVER=ser.ver.add
PORT=2222

DIR1=/dir1/
DIR2=/dir2/

OPTIONS='-o allow_other -o kernel_cache -o auto_cache -o reconnect -o compression=no -o cache_timeout=600 -o ServerAliveInterval=15'

sshfs $OPTIONS $RUSER@$SERVER:$DIR1 $DIR2

exit 0
