#!/bin/bash
# dependencies: wget
# will download all XML files defined by URL in separate text file 
# will save to one XML file named by a timestamp 
# will write progress (and erors) to a log file 
# will retry up to 3 times 
# will download a file only if the version on server is newer than local copy
# will wait between retrievals
# EC2 instance does not support --timestamping 
# to consider: --execute robots=off 
# to consider: --user-agent=Mozilla
# to consider: ‐‐limit-rate=20k
# to consider: --spider 

filename=`date +"%Y%m%d-%H%M%S"`
start=`date +%s`

echo "----------------- download_feed.sh -----------------" \
>> /home/ec2-user/environment/download_feed.log

echo "Starting to execute:         `date -u +"%Y-%m-%d %H:%M:%S"` UTC" \
>> /home/ec2-user/environment/download_feed.log

wget --tries=3 --wait=1 --random-wait \
--input-file=/home/ec2-user/environment/src/feed.txt \
--output-document=/home/ec2-user/environment/data/$filename.xml \
--output-file=/home/ec2-user/environment/data/$filename.log

end=`date +%s`

echo "... finished successfully:   `date -u +"%Y-%m-%d %H:%M:%S"` UTC" \
>> /home/ec2-user/environment/download_feed.log

runtime=$((end-start))

filesize=`ls -sh /home/ec2-user/environment/data/"$filename".xml | awk '{ print $1 }'`
# filesize=`du -k /home/ec2-user/environment/data/"$filename".xml | cut -f1`

echo "Output: $filename.xml" \
>> /home/ec2-user/environment/download_feed.log

echo "Runtime: $runtime s" \
>> /home/ec2-user/environment/download_feed.log

echo "Filesize: $filesize" \
>> /home/ec2-user/environment/download_feed.log
