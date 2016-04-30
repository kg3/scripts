#!/bin/bash
# compile android app & sync to online folder
# continuously to watch how fast your group is making changes

CLOUDDIR='~/Google\ Drive/SFTWRE\ ENGENG/Apk/'

sleep 1
git pull

sleep 1
./gradlew assembleDebug

sleep 1
cp app/build/outputs/apk/*.apk $CLOUDDIR

ls -alh app/build/outputs/apk/

exit 0
