#!/bin/bash
# Dirty way to do it but it works. very manual.
# collect the urls for each post and put them into one file: urlList.txt; right-click "save-link" on button to play lecture
# it will downloa the mp3's & flv's of each lecture.
# urlList.txt:
#   https://uuu-web0.echo360.net/echocontent/1111/0/AAAA1111-0000-111A-0000-111222333444/presentation.xml?1112223334444
#

CLASSURL=urlList.txt

flvdir=flv
mp3dir=mp3

PPT=audio-vga.m4v
MP3=audio.mp3

## MKDIR ##
if [ ! -d "$flvdir” ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
	mkdir $flvdir
fi

if [ ! -d "$mp3dir” ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
	mkdir $mp3dir
fi

# LOOP START #
for i in $(cat $CLASSURL);
	do
		#echo $i
		if [[ $i == *'http'* ]]
 		then
			URL=$i
			#echo "URL=$URL"
		else
			DIR=$i
		fi;
		
		if [[ $URL != '' ]]
		then
			echo "wget --no-check-certificate -O $mp3dir/$DIR.mp3 $URL$MP3"
			wget --no-check-certificate -O $mp3dir/$DIR.mp3 $URL$MP3
			echo "wget --no-check-certificate -O $flvdir/$DIR.flv $URL$PPT"
			wget --no-check-certificate -O $flvdir/$DIR.flv $URL$PPT
	    fi;
done;

exit 0
