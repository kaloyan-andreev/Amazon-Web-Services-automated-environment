import boto3
import json

ec2=boto3.resource('ec2')

instances=ec2.instances.filter(Filters = [
    {
        'Name':'tag:Importance',
        'Values':['Transition']
    }
    ])

def lambda_handler(event, lambda_context):
    for ins in instances:
        try:
            instances.stop()
            return(f'Instances are stoped')
        except:
            return(f'Error while stoping instances')