#!/bin/bash
cd
java -jar /home/jenkins/swarm.jar -master $JENKINS_SERVER -username $JENKINS_USER -password $JENKINS_PASSWORD
