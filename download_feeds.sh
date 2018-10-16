#!/bin/bash
# dependencies: wget
# will download all XML files defined by URL in separate text file 
# will save to one XML file named by a timestamp 
# will write progress (and erors) to a log file 
# will retry up to 3 times 
# will download a file only if the version on server is newer than local copy
# will wait between retrievals
# EC2 does not support --timestamping 
# to consider: --execute robots=off 
# to consider: --user-agent=Mozilla
# to consider: ‐‐limit-rate=20k
# to consider: --spider 

wget --tries=3 --wait=1 --random-wait \
--input-file=src/feeds.txt \
--output-document=data/`date +"%Y%m%d-%H%M%S"`.xml \
--output-file=data/`date +"%Y%m%d-%H%M%S"`.log

