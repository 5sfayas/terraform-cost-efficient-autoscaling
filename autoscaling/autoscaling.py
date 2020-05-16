import boto3
import os
# Boto Connection
# aws_region, autoscaling-group-name,min,max and desired capacity has to be passed
asg = boto3.client('autoscaling','os.environ[aws_region]')
def lambda_handler(event, context):
  response = asg.update_auto_scaling_group(AutoScalingGroupName=os.environ['asg_name'],MinSize=os.environ['min'],DesiredCapacity=os.environ['desired'],MaxSize=os.environ['max'])
