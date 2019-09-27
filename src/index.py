import json
import numpy as np
import pandas as pd
import re
from urllib.request import urlopen
from bs4 import BeautifulSoup

def hello(event, context):

    url = "https://www.nbcnews.com/news/world/danes-react-anger-after-trump-cancels-state-visit-over-greenland-n1044691"
    html = urlopen(url)

    soup = BeautifulSoup(html, 'lxml')
    type(soup)
    title = soup.title

    text =[''.join(s.findAll(text=True))for s in soup.findAll('p')]

    body = {
        "message": "Python AWS Lambda",
        "input": event['body'],
        "content": text
    }

    response = {
        "statusCode": 200,
        "body": json.dumps(body)
    }

    return response
