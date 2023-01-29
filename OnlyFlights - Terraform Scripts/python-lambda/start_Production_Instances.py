import boto3
import json

ec2=boto3.resource('ec2')

instances=ec2.instances.filter(Filters = [
    {
        'Name':'tag:Importance',
        'Values':['Production']
    }
    ])

def lambda_handler(event, lambda_context):
    for ins in instances:
        try:
            instances.start()
            return(f'Instances are started')
        except:
            return(f'Error while starting instances')