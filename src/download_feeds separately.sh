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
echo "$timestamp Started running download_feeds_separately.sh" \
>> /home/ec2-user/environment/activity.log

# for i in [enter list of commands]; \
# do history | grep -i "$i" >> ~/histories/"${i}"_hist.txt; \
# done

for i in `cat src/sample_feeds.txt`; do echo "${i}"; done

for i in `cat src/sample_feeds.txt`; do echo filename="${i}_`date +"%Y%m%d-%H%M"`; done

for i in `cat sample_feeds.txt`; \
filename="${i}""_`date +"%Y%m%d-%H%M"`; \
echo filename; done 
do wget --tries=3 --wait=1 --waitretry=3 --random-wait \

--output-document=/home/ec2-user/environment/data_dump/$filename.xml \
--output-file=/home/ec2-user/environment/data_dump/$filename.log \
--rejected-log= 

"$i"; \
done

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
