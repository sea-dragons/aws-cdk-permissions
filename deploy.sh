#!/bin/bash

### AWS Parameters
export STACK_NAME='AwsCdkPermissionsStack'
export CDK_DEFAULT_ACCOUNT='<account>'
export AWS_REGION='<region>'
export PROFILE='<profile>'

### GitHub Parameters
githubOrg='<organisation>'
githubRepo='<repository>'
githubBranch='<branch>'

### Deploy/Destroy
if [[ $1 == 'deploy' ]]
then
    cdk deploy \
    $STACK_NAME \
    --require-approval never \
    --parameters accountNumber=$CDK_DEFAULT_ACCOUNT \
    --parameters githubOrg=$githubOrg \
    --parameters githubRepo=$githubRepo \
    --parameters githubBranch=$githubBranch \
    --profile $PROFILE

elif [[ $1 == 'destroy' ]]
then 
    cdk destroy \
    $STACK_NAME \
    --force \
    --profile $PROFILE

else
    echo 'invalid CDK option, please use deploy or destroy'

fi
