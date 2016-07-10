#/bin/bash
#  stream from vlc or fflpay an online tv link
# Live News Links
# http://database.freetuxtv.net/

#ENGLISH="rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live/aljazeera_eng_high"
ENGLISH="rtmp://aljazeeraflashlivefs.fplive.net:443/aljazeeraflashlive-live?videoId=883816736001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId=/aljazeera_eng_med?videoId=883816736001&lineUpId=&pubId=665003303001&playerId=751182905001&affiliateId= live=true"
BALKAN="rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live/aljazeera_balkans_high"
DOCUMENTARY="rtmp://aljazeeraflashlivefs.fplive.net:1935/aljazeeraflashlive-live/aljazeera_doc_high"
MISIR="rtmp://aljazeeraflashlivefs.fplive.net/aljazeeraflashlive-live/aljazeera_misr_high"
RT="http://rt-a.akamaihd.net/ch_01@325605/720p.m3u8"

# check args
if [ $# -lt 1 ]
then
	echo "    Stream: [stream] [player: default vlc] "
	echo "    -=Streams=-"
	echo "	      -r RT Live"
	echo "        -a AJ Live"
	echo "        -d AJ Documentary"
	echo "        -b AJ Balkans"
	echo "        -e AJ Egypt"
	echo "    -=Players=-"
	echo "        -f [ stream with ffplay ]"
	echo
	exit 85
fi

case "$2" in
-f) player=1
    ;;
*) player=2
    ;;
esac

function play {
case "$player" in

1) ffplay -i $1
    ;;
2) vlc --open $1
    ;;
esac
}

case "$1" in

-r) play $RT
    ;;
-a) play $ENGLISH
    ;;
-d) play $DOCUMENTARY
    ;;
-b) PLAY=$BALKAN
    ;;
-e) PLAY=$MISIR
    ;;
*) echo "Invalid option"
   ;;
esac

exit 0
