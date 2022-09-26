import * as cdk from 'aws-cdk-lib';
import * as iam from 'aws-cdk-lib/aws-iam'
import { Construct } from 'constructs';
// import { isMainThread } from 'worker_threads';

export class AwsCdkPermissionsStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const accountNumber = new cdk.CfnParameter(this, "accountNumber", {
      type: "String",
      description: "The AWS account that the role will be deployed in"
    });

    const githubOrg = new cdk.CfnParameter(this, "githubOrg", {
      type: "String",
      description: "The GitHub Organisation that contains the AWS CDK code"
    });

    const githubRepo = new cdk.CfnParameter(this, "githubRepo", {
      type: "String",
      description: "The GitHub Repository that contains the AWS CDK code"
    });

    const githubBranch = new cdk.CfnParameter(this, "githubBranch", {
      type: "String",
      description: "The GitHub Branch that contains the AWS CDK code"
    });

    const roleName = new cdk.CfnParameter(this, "roleName", {
      type: "String",
      description: "The Role name to be deployed",
      default: "aws-cdk-access-role"
    });

    const principal = new iam.WebIdentityPrincipal(
      `arn:aws:iam::${accountNumber.valueAsString}:oidc-provider/token.actions.githubusercontent.com`, {
        'StringEquals': {
          'token.actions.githubusercontent.com:aud': 'sts.amazonaws.com',
          'token.actions.githubusercontent.com:sub': `repo:${githubOrg.valueAsString}/${githubRepo.valueAsString}:ref:refs/heads/${githubBranch.valueAsString}`
        }
      }
    )

    const assumeRolePolicy = new iam.PolicyDocument({
      statements: [
        new iam.PolicyStatement({
          effect: iam.Effect.ALLOW,
          actions: ['sts:AssumeRole'],
          resources: ['arn:aws:iam::*:role/cdk-*']
        })
      ]
    })

    const accessRole = new iam.Role(this, 'aws-cdk-access-role', {
      assumedBy: principal,
      roleName: `${roleName.valueAsString}`,
      description: 'Role to allow access for GitHub Actions to deploy CDK stacks',
      inlinePolicies: {
        assumeRole: assumeRolePolicy
      }
    })

  }
}
