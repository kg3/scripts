#!/bin/bash
# random random keyfile generator with -slight- obfuscation

ARGS=6
E_BADARGS=85 

if [ $# -ne "$ARGS" ]
then
 echo
 echo "Usage: `basename $0` [keyfile_name] [extension] [amount] {bytes} {min-count} {max-count}"
 echo "Notice: [sudo apt-get install randomsound] before         use"
 echo "uses dd with /dev/urandom"
 echo 
 echo "Example: `basename $0` picture jpg 10 1024 512 4096"
 echo "--will make directory named picture_10"
 echo "--with 10 keyfiles named picture1.jpg to picture10.jpg"
 echo "--keyfile size will be random between .524288MB &         4.194304MB"
 echo 
 exit $E_BADARGS
fi

filename=$1
extension=$2
amount=$3
bytes=$4
count_min=$5
count_max=$6

echo
echo "Restarting entropy with randomsound (doesn't always have the best entropy from startup)"
sudo /etc/init.d/randomsound restart


mkdir "$filename"_"$amount"


maxsize=`echo "$bytes*$count_max*.000001" | bc`
minsize=`echo "$bytes*$count_min*.000001" | bc`
echo
echo "MIN: $minsize""MB"" MAX: $maxsize""MB"


for a in `seq $amount`
do
 echo
 entropy1=`cat /proc/sys/kernel/random/entropy_avail`
 echo -n "Making $filename$a.$extension with entropy of:$entropy1"


 number=0
 FLOOR=$count_min 
 RANGE=$count_max

 #initialize random number range
 while [ "$number" -le $FLOOR ]
 do
 SEED=$(head -1 /dev/urandom | od -N 1 | awk '{ print $2         }')
 RANDOM=$SEED
 number=$RANDOM 
 let "number %= $RANGE" # Scales $number down within $RANGE.
 done


 currentfilesize=`echo "$bytes*$number*.000001" | bc`    #helpful for large ones

 echo " will be $currentfilesize""MB"
 echo "dd if=/dev/urandom of=./"$filename"_"$amount"/"$filename""$a"."$extension" bs=$bytes count=$number"

 dd if=/dev/urandom of=./"$filename"_"$amount"/"$filename""$a"."$extension" bs=$bytes count=$number

 entropy2=`cat /proc/sys/kernel/random/entropy_avail`
 totale=`echo "$entropy1-$entropy2" | bc`

 echo ".:: Pausing to generate more entropy ($totale used $entropy2 left) ::."
 sleep 3 

 echo
done


echo "Made $a keyfile(s) in /""$filename""_""$amount"
echo


exit 0
