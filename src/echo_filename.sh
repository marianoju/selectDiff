#!/bin/bash

for i in `cat src/sample_feeds.txt`; 
do sed -i 's/^http:\/\/|^https:\/\///g' ${i} | echo "${i}_`date +"%Y%m%d-%H%M"`"; 
done
