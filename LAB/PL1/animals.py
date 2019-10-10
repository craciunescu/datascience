# Needed imports.
import csv
import re
import bs4
from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup

# Accessed link.
url = "https://a-z-animals.com/animals"

# Open connection and retrieve contents.
uClient  = uReq(url)
pageHtml = uClient.read()
uClient.close()

# Parse the content.
pageSoup = soup(pageHtml, "html.parser")

# Retrieve table rows to parse.
names = list(map(lambda l: l.text, pageSoup.findAll("b")))[2:595]

# Obtain lifespan of each animal.
animals = []

for name in names:
    try:
        # Access page of animal.
        uClient = uReq("https://a-z-animals.com/animals/"+name.replace(" ","-").lower())
        pageHtml = uClient.read()
        uClient.close()

        # Parse the page.
        animalSoup = soup(pageHtml, "html.parser")

        # Obtain info.
        attributes = animalSoup.findAll("table")[1].findAll("tr")
        lifespan = list(filter(lambda l: "Lifespan" in l.text, attributes))[0].find_all("td")[1].text.split()[0]

        animals.append([name, lifespan])

    except Exception:
        print("Animal " + name + " does not have same standard.")

# Create .CSV file
with open("animals.csv", "w", newline = "") as csvfile:
    writer = csv.writer(csvfile, delimiter = ",", quotechar = '"', quoting =
    csv.QUOTE_MINIMAL)

    for animal in animals:
        writer.writerow(animal)
