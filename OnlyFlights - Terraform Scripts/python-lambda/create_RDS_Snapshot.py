import boto3
import datetime

def lambda_handler(event, context):
    client = boto3.client('rds')
    
    client.create_db_snapshot(
        DBInstanceIdentifier='onlyflights-database', 
        DBSnapshotIdentifier='onlyflights-database-%s' % datetime.datetime.now().strftime("%y-%m-%d-%H"),
        Tags=[
            {
                'Key': 'Importance',
                'Value': 'Database'
            },
        ]
    )
    
    for snapshot in client.describe_db_snapshots(DBInstanceIdentifier='onlyflights-database', MaxRecords=50)['DBSnapshots']:
        create_ts = snapshot['SnapshotCreateTime'].replace(tzinfo=None)
        if create_ts < datetime.datetime.now() - datetime.timedelta(days=7):
            client.delete_db_snapshot(
                DBSnapshotIdentifier=snapshot['DBSnapshotIdentifier']
            )
            return ("Snapshot with the following id was deleted:", snapshot['DBSnapshotIdentifier'])

            