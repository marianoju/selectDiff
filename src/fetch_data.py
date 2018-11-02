#!/usr/bin/env python3
# coding: utf-8
# Using a `for` loop to iterate urllib.request.urlopen over all URL defined in 
# a text file to return a  HTTP response object and write it to a file using 
# shutil.copyfileobj. The output is written to dedicated folders and a 
# timestamp appended to the filenames. 
# Caveat: A single HTTP Error (e.g. 404: Not Found) will break the loop!

# 1) functions that handle URL strings 
import re
import os

# removes the protocol from the URL string 
def remove_protocol(url):
    return re.sub('^http://|^https://', '', url)
# substitutes all characters from the URL string 
# with exception of letters, digits and underscores
def substitute_but_alnum(string):
    return re.sub(r'\W+', '_', string)
def sanitize_string(var):
    return substitute_but_alnum(remove_protocol(var))
# preprares directory structure for writing files 
def mkdir(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)

# 2) loops over URL in source file and writes response to file
from datetime import datetime
import urllib.request
import shutil
source = open('/home/ec2-user/environment/src/sample_feeds.txt','r')

# Download the file from `url` and save it locally under `filename`:
for url in source:
    string = sanitize_string(url)
    timestamp = datetime.now().strftime("%Y-%m-%d_%H%M%S")
    filename = '_'.join([string, timestamp + '.xml'])
    directory = '/'.join(['/home/ec2-user/environment/data_lake', string])
    path = '/'.join([directory, filename])
    mkdir(directory)
    print ('[+] downloading ' + url.strip())
    with urllib.request.urlopen(url) as response, open(path, 'wb') as output:
        shutil.copyfileobj(response, output)
