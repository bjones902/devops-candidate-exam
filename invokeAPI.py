import json
import requests
import base64

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
            responseList = json.loads(response.content)
            logResult = responseList['LogResult']
            decodedLogResult = base64.b64decode(logResult)
            logResultString = decodedLogResult.decode('utf-8')
            return {
                'statusCode': 200,
                'body': json.dumps('Request successful'),
                'LogResultBase64': json.dumps(logResultString)
            }
        else:
            return {
                'statusCode': response.status_code,
                'body': json.dumps('Request failed with status code: ' + str(response.status_code))
            }
    except Exception as e:
        return e
    