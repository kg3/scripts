#!/bin/bash
# various useful commands to download entire lectures from prof's website.
# on various professors combinations of all of these have worked well.
#
# wget $url ---- creates index or class#.html
#
# usually successful grepping
# grep -o 'href[^>]*"' index.htm  |grep -v http |cut -d"=" -f2 |cut -d "\"" -f2

# when all links play well
for i in $(cat index.html |grep "<A HREF" |grep -v "http" | cut -d "\"" -f 2); 
  do 
    wget http://URL/$i; 
done;

# when links are kind of obscured;
for i in $(grep -o 'href[^>]*"' index.html |grep -v http |cut -d"\"" -f 2); 
  do 
    wget http://url/~prof/class/$i; 
done

# for specific types of files when links are kind of obscured or excessive external links
for i in $(grep -o 'http[^>]*.pdf' index.html); 
  do 
    wget $i; 
done

exit 0
