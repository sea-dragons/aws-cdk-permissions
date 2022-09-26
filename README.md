# AWS CDK Permissions

This repository allows you to use AWS CDK to automate the creation of a role that GitHub Actions can assume to automatically deploy further AWS infrastructure. This requires that AWS CDK is already installed and a profile is set-up to be used. The role name defaults to `aws-cdk-access-role` which then can be added to the GitHub Actions workflows.

Edit the AWS/GitHub paramters in `deploy.sh` to be the ones relevant to your project.

The following commands can be run to deploy/destroy the role:

```
source ./deploy.sh 'deploy'
source ./deploy.sh 'destroy'
```
