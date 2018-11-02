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

start=`date +%s`

timestamp=`date -Iseconds -d @$start`
echo "$timestamp Started running download_feeds.sh" \
>> /home/ec2-user/environment/activity.log

filename=`date +"%Y%m%d-%H%M"`
wget --tries=3 --wait=1 --random-wait \
--input-file=/home/ec2-user/environment/src/feeds.txt \
--output-document=/home/ec2-user/environment/data_dump/$filename.xml \
--output-file=/home/ec2-user/environment/data_dump/$filename.log

end=`date +%s`

timestamp=`date -Iseconds -d @$end`
echo "$timestamp Finished running download_feeds.sh" \
>> /home/ec2-user/environment/activity.log

runtime=$((end-start))

filesize=`ls -sh /home/ec2-user/environment/data_dump/"$filename".xml | awk '{ print $1 }'`
# filesize=`du -k /home/ec2-user/environment/data_dump/"$filename".xml | cut -f1`

echo "$filename.xml, $runtime, $filesize" \
>> /home/ec2-user/environment/src/download_feeds.log
