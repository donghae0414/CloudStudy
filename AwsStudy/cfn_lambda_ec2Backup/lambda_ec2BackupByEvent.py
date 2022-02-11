import boto3
import datetime
import sys
import traceback

###
### event pattern
###
# {
#   "source": [
#     "aws.ec2"
#   ],
#   "detail-type": [
#     "EC2 Instance State-change Notification"
#   ],
#   "detail": {
#     "state": [
#       "stopped",
#       "terminated"
#     ],
#     "instance-id": [
#       "i-09a25980f1efe3010"
#     ]
#   }
# }

region = 'ap-northeast-2'

def backup_instances(ec2_client, backup_list):
    print("Function : backup_instances" + "\n")

    filtered_ec2_list = ec2_client.describe_instances(
        Filters=[
            {
                'Name': 'instance-id',
                'Values': backup_list
            }
        ]
    )['Reservations']
    #print(filtered_ec2_list)

    for ec2 in filtered_ec2_list:
        ec2_info = ec2['Instances'][0]
        
        try:
            instance_name = [tag.get('Value') for tag in ec2_info['Tags'] if tag['Key'] == 'Name'][0]
        except:
            instance_name = ec2_info['InstanceId']
            
        print("Backup Instance Name : " + instance_name)
        
        #
        # create AMI
        #
        try:
            image = ec2_client.create_image(
                InstanceId=ec2_info['InstanceId'],
                Name="{}-backup-{}".format(instance_name, datetime.datetime.now().strftime('%Y-%m-%d-%H-%M')),
                Description="Backup of {} from {}".format(instance_name, ec2_info['InstanceId']),
                NoReboot=True,
                DryRun=False    #DryRun = 실제로 실행하지 않고 시나리오를 테스트
            )
            ec2_client.create_tags(Resources=[image['ImageId']], Tags=[{'Key': 'Name', 'Value': instance_name}])
            print("New AMI : {}".format(image['ImageId']))
        except:
            print("Failure trying to create image or tag image. See/report exception below")
            exc_info = sys.exc_info()
            traceback.print_exception(*exc_info)


def lambda_handler(event, context):
    ec2_client = boto3.client('ec2', region_name=region)
    backup_instances(ec2_client, [event['detail']['instance-id']])
    
    return {
        'statusCode': 200
    }