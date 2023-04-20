import json
import requests

def lambda_handler(event, context):
    url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
    headers = {
        'X-Siemens-Auth': 'test',
        'Content-Type': 'application/json'
    }
    try:
        payload = json.dumps(event)
        print(event)
        response = requests.post(url, headers=headers,data=payload)

        if response.status_code == 200:
            return {
                'statusCode': 200,
                'body': json.dumps('Request successful')
            }
        else:
            return {
                'statusCode': response.status_code,
                'body': json.dumps('Request failed with status code: ' + str(response.status_code))
            }
    except Exception as e:
        return e
    