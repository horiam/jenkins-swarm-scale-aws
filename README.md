# jenkins-swarm-scale-aws

An AWS cloud formation stack with one Jenkins master and one to multiple swarm slaves that scale in and out
 
## What it does

- Scale out one instance if there is minimum 2 jenkins jobs queued for more than one minute
- Scale in one instance if there is maximum zero busy slaves for more than one minute
- Build from the basic Ubuntu 16.04 ami
- Be able to run on any AWS account

## To get it running

#### What you need 
- AWS account
- Packer installed https://www.packer.io/
- one VPC in AWS 
- one subnet with auto-assign public IP enabled in AWS

#### Build the amis
You need to build the image for the Jenkins server and Jenkins slaves from a Ubuntu 16.04 ami.
```
packer build -var 'vpc_id=vpc-xxxxxx' -var 'subnet_id=subnet-xxxxxx' -var 'sg_id=sg-xxxxxx' client/swarm.json
packer build -var 'vpc_id=vpc-xxxxxx' -var 'subnet_id=subnet-xxxxxx' -var 'sg_id=sg-xxxxxx' server/jenkins.json
```

#### Deploy the stack
Once you have built the required images, you can deploy the cloud formation stack from the template.
You can do this in the AWS Cloud Formation console; you will be asked to provide certain inputs during the deploy. Give it 7 to 12 minutes in order to have everything started and set up. Then the URL of the Jenkins master will be in the output.


