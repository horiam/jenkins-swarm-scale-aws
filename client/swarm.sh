#!/bin/bash
cd
java -jar /home/jenkins/swarm.jar -master http://${JENKINS_DNS_NAME}:8080 -username $JENKINS_USER -password $JENKINS_PASSWORD
