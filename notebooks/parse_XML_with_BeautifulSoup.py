from bs4 import BeautifulSoup
import urllib.request

url = 'https://stackoverflow.com/feeds/'

with urllib.request.urlopen(url) as response:
    soup = BeautifulSoup(response.read(), "lxml-xml")

print(soup.title.string)
print("---")
print(soup.find_all('title'))
print("---")
print(soup.entry.title.string)
