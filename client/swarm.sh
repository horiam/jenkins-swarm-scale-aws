#!/bin/bash
REGION=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep -oP '(?<="region" : ").*(?=")')
INSTANCE_ID=$(aws cloudformation describe-stack-resource --stack-name $STACK_NAME --logical-resource-id instJenkinsServer --region $REGION | jq -r '.StackResourceDetail.PhysicalResourceId')
JENKINS_SERVER=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --region $REGION  | jq -r '.Reservations[0].Instances[0].PrivateDnsName')
cd
java -jar /home/jenkins/swarm.jar -master http://${JENKINS_SERVER}:8080 -username $JENKINS_USER -password $JENKINS_PASSWORD
