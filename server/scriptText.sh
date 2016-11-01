#!/bin/bash

SCRIPT=$(cat)
PASSWORD=$(cat ~jenkins/.jenkins/secrets/initialAdminPassword)
CRUMB=$(curl -s -u admin:$PASSWORD 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
curl -d "script=$SCRIPT" -H $CRUMB -u admin:$PASSWORD http://localhost:8080/scriptText
