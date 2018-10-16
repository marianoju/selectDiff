from bs4 import BeautifulSoup
import urllib.request
import re
import os

# reads XML file from online source 
url = 'https://stackoverflow.com/feeds'

# parses XML document and returns a `BeautifulSoup` object (aka soup)
with urllib.request.urlopen(url) as response:
    soup = BeautifulSoup(response.read(), "lxml-xml")

# functions that handle content 

# replaces HTML tags with nothing 
def strip_tags(description):
    return re.sub('<.*?>', '', description)


def substitute_whitespaces(text):
    return re.sub('\s+', ' ', text).strip()
    # alternatively: return ' '.join(text.split())
    
def cleanse_text(ore):
    return strip_tags(substitute_whitespaces(ore))

# functions that handle URL strings 

# removes the protocol from the URL string 
def remove_protocol(url):
    return re.sub('^http://|^https://', '', url)

# substitutes all characters from the URL string 
# with exception of letters, digits and underscores
def substitute_but_alnum(string):
    return re.sub(r'\W+', '_', string)
    # '\W == [^a-zA-Z0-9_] 

def sanitize_string(var):
    return substitute_but_alnum(remove_protocol(var))

# preprares directory structure for writing files 
def mkdir(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)

# finds all entries in the soup object 
# and writes summary to TXT files 
# in source-dedicated directories
for entry in soup.find_all('entry'):
    filename = f'{sanitize_string(entry.id.string)}.txt'
    url = sanitize_string(url)
    directory = '/'.join(['../data', url])
    path = '/'.join([directory, filename])
    # TODO: add entry.published.string to filename or path
    mkdir(directory)
    with open(path, 'w') as file:
        pure_text = ''
        # .stripped_strings is a Beautiful Soup generator 
        # intended to remove extra whitespace
        for string in entry.summary.stripped_strings:
            pure_text += cleanse_text(string)
        file.write(pure_text)
