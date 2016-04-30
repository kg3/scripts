#!/bin/bash
# compress all p2p block files into one big blocklist, for use in different systems
# Hence, a mac hosts file etc.
#
# !!!!
#	sort -u ipBlockList.txt > sorted_ipBlocklist.txt
#	awk '!x[$0]++' sorted_ipBlocklist.txt > ipBlockList.txt
# !!!!
# Make a p2p file compatible with iptables hosts.deny
#
# MAC
# sed -e 's/^/127.0.0.1\ \ \ \ /' ipBlockList.txt > macHostsBlock.txt
# dscacheutil -flushcache;sudo killall -HUP mDNSResponder

# temp
compdir=compiledlist
name=all.block
all=$compdir/$name
dedup=$compdir/dedup.block
final=ipBlockList.txt

# array of downloaded p2p lists
#p2pfiles=( ipfilterX.p2p ipfilterX2.p2p ipfilterX_jupiter.p2p nXs.23.BrutuX.p2p nXs23.Malicia.p2p nXs23.Spamya.p2p nxs23.Malwar.AMOD.p2p )

p2pfiles=`ls *.p2p`
# not normally needed
# whitelist=( VIACOM "WARNER BROS" )

# Functions #

function checkDirMakeDir {
echo "creating temp directory"
if [ ! -d "$1" ]; then
    # if $DIRECTORY doesn't exist.
    mkdir $1
fi
}

function touchFiles {
echo "creating temp files"
for arg in "$*"
do
    touch $arg
done
}

function makeBigBlockList {
# $arg must be array
for file in ${p2pfiles[@]}
do
  	echo "Adding: $file into $all"

    if [ -f $file ];
    then
        cat $file >> $1
    else
        echo "File $file does not exist."
        exit 1
    fi
done

# remove comments
sed -i '' '/^#/d' $1
# remove end of line comments
sed -i '' 's/#.*$//' $1
# remove empty lines
sed -i '' '/^$/d' $1
}

function whiteList {
# Any line matching a p2p comment will remove the line
# shouldn't be needed but just in case
for white in ${whitelist[@]}
do
    echo "removing $white"
    grep -v $white $all > $dedup
    mv $dedup $all
done
}

function removeDuplicates {
echo "removing duplicates"
awk '!x[$0]++' $1 > $dedup;
mv $dedup $1
}

function grabIPs {
# grab IPs
cat $1 | cut -d":" -f 2 > $dedup
mv $dedup $1
}

function dos2unix {
tr -d '\015' < $1 > $dedup
mv $dedup $1
}

function placeInShield {
# for first run after: cp /etc/e2guardian/lists/bannediplist{,bak}
# cat /etc/e2guardian/lists/bannediplist.bak > /etc/e2guardian/lists/bannediplist
 cat $1 > /etc/e2guardian/lists/bannediplist
}

function finish {
 mv $1 $final
 echo "cleaning up"
 rm -rf $2
}

function makeMACOSlist {
 sed -e 's/^/127.0.0.1\ \ \ \ /' ipBlockList.txt > macHostsBlock.txt
 dscacheutil -flushcache;sudo killall -HUP mDNSResponder
}

# check directory
checkDirMakeDir $compdir

# touch files
touchFiles $all $dedup

# bring all lists into one big file
makeBigBlockList $all

# whitelist ip's; call before grab; usually not needed
# whiteList "WARNER BROS" NAVY ARMY ETC.

# remove dupicates
removeDuplicates $all

# grab ip's
grabIPs $all

# convert Dos to Unix
dos2unix $all

# copy over /etc/e2guardian/lists/bannediplist
# placeInShield $final

# clean up temp, move list to .
finish $all $compdir

exit 0
