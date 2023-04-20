import json
import http.client
#import requests

def lambda_handler(event, context):
    url = 'ij92qpvpma.execute-api.eu-west-1.amazonaws.com'

    headers = {
        'X-Siemens-Auth': 'test',
        'Content-Type': 'application/json'
        }
    payload = json.dumps(event)
    connection = http.client.HTTPSConnection(url)

    connection.request('POST', '/candidate-email_serverless_lambda_stage/data', payload, headers)
    response = connection.getresponse()