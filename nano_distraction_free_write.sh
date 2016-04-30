#!/bin/bash
# distraction free writing with nano
COLS=125
DIR=~/destraction/free/write
DATE=`date +%d%b%y`
DOIT=create

nano -Wtx -r $COLS $DIR$DATE"_"$DOIT.txt
