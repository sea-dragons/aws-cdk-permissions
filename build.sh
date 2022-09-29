#!/bin/bash

### Deploy/Destroy
if [[ $1 == 'deploy' ]]
then
    cdk deploy \
    'AwsCdkPermissionsStack' \
    --require-approval never \
    --parameters accountNumber=$CDK_DEFAULT_ACCOUNT \
    --parameters githubOrg=$GITHUB_ORG \
    --parameters githubRepo=$GITHUB_REPO \
    --parameters githubBranch=$GITHUB_BRANCH \
    --profile $PROFILE

elif [[ $1 == 'destroy' ]]
then 
    cdk destroy \
    'AwsCdkPermissionsStack' \
    --force \
    --profile $PROFILE

else
    echo 'invalid CDK option, please use deploy or destroy'
fi
