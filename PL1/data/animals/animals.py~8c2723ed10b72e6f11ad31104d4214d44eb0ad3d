################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL1                 #
#                               Grupo 4 - P1                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

# Imports and dependencies.
import csv
import re
import bs4
import time
import sys

from urllib.request import urlopen as url_request
from bs4 import BeautifulSoup as soup

""" Downloads the contents of a page and returns the parsed HTML. """
def get_url(url):
    
    try:
        url_client = url_request(url)
        page_html  = url_client.read()
        url_client.close()

        return soup(page_html, "html.parser")

    except Exception:
        print("An error has occurred while parsing " + url)

""" Retrieves a list with all elements to follow when scraping. """
def get_follow_elements(url_parsed):
    return list(map(lambda l: l.text, url_parsed.findAll("b")))[2:595]

""" Generates the follow link for the provided element. """ 
def get_follow_link(root_url, element):
    return root_url+element.replace(" ", "-").lower()

""" Obtains the information specified from the provided web elements. """ 
def get_elements_data(root_url, elements_web, wanted):

    elements_parsed = []

    for idx, element in enumerate(elements_web):
        try:
            # Access page of each animal.
            content     = get_url(get_follow_link(root_url, element))
            attributes  = content.findAll("table")[1].findAll("tr")
            scraped     = list(filter(lambda l: wanted in l.text, attributes))[0]
            data        = scraped.find_all("td")[1].text.split()[0]
            
            # Update progress bar.
            update_progress("Downloading", round(idx/len(elements_web), 2))

            # Check data is pure and not range.
            if "-" in data:
                values = list(map(int, data.split("-")))
                data   = sum(values) / len(values)

            elements_parsed.append([element, data])

       # Revisar except condiciones.

        except:
            print("Element: " + element + " could not be scraped.") 
    
    return elements_parsed

""" Displays or updates a console progress bar 
- Accepts a float between 0 and 1. Any int will be converted to a float.
- A value under 0 represents 'HALT'.
- A values at 1 or bigger represents 100%
"""
def update_progress(action, progress):
    # Modify to change length of bar.
    barLength = 50
    status = ""

    # Progress bar logic.
    if isinstance(progress, int):
        progress = float(progress)

    if not isinstance(progress, float):
        progress = 0
        status = "error: progress var must be float\r\n"
    
    if progress < 0:
        progress = 0
        status = "Halt...\r\n"
    
    if progress >= 1:
        progress = 1
        status = "Done...\r\n"
    
    block = int(round(barLength*progress))
    text = "\r[{0}] {1}% {2}".format( "#"*block + "-"*(barLength-block), progress*100, status)
    sys.stdout.write(action)
    sys.stdout.write(text)
    sys.stdout.flush()

""" Writes the provided content to a CSV file. """
def to_CSV(name, content, headers):
    
    # Create CSV writer.
    with open(name + ".csv", "w", newline = "") as csvfile:
        writer = csv.writer(
            csvfile, 
            delimiter = ",", 
            quotechar = '"', 
            quoting = csv.QUOTE_MINIMAL)
        
        # Headers.
        writer.writerow(headers)
          
        # Actual content.
        for datum in content:
            writer.writerow(datum)

""" Scrapes the data. """
def scrape():
    url        = "https://a-z-animals.com/animals/"
    parsed_url = get_url("https://a-z-animals.com/animals/")
    names      = get_follow_elements(parsed_url)
    animals    = get_elements_data(url, names, "Lifespan")
    to_CSV("animals", animals, ["name","lifespan"])

scrape()
