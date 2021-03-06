#!/bin/bash

REGION=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep -oP '(?<="region" : ").*(?=")')
while true;
do 
    QUEUE=$(curl -s -u $USER:$PASSWORD http://localhost:8080/queue/api/xml | grep -o '<item' | wc -l)
    BUSY=$(curl -s -u $USER:$PASSWORD http://localhost:8080/computer/api/xml | xmllint --xpath "*/busyExecutors/text()" - )
	if [ $? -ne 0 ]; then
		BUSY=0
	fi
    echo "REGION=$REGION, QUEUE=$QUEUE, BUSY=$BUSY"
    aws cloudwatch put-metric-data --metric-name "busy-nodes" --namespace $NAMESPACE --value $BUSY --region $REGION
    aws cloudwatch put-metric-data --metric-name "queue-size" --namespace $NAMESPACE --value $QUEUE --region $REGION
    sleep 15s
done
