import * as cdk from 'aws-cdk-lib';
import * as iam from 'aws-cdk-lib/aws-iam'
import * as gitHub from './account-details.json'
import * as tags from './default-tags.json'
import { Construct } from 'constructs';

export class AwsCdkPermissionsStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const principal = new iam.WebIdentityPrincipal(
      `arn:aws:iam::${process.env.CDK_DEFAULT_ACCOUNT}:oidc-provider/token.actions.githubusercontent.com`, {
        'StringEquals': {
          'token.actions.githubusercontent.com:aud': 'sts.amazonaws.com',
          'token.actions.githubusercontent.com:sub': `repo:${gitHub.GitHubOrg}/${gitHub.GitHubRepo}:ref:refs/heads/${gitHub.GitHubBranch}`
        }
      }
    );

    const assumeRolePolicy = new iam.PolicyDocument({
      statements: [
        new iam.PolicyStatement({
          effect: iam.Effect.ALLOW,
          actions: ['sts:AssumeRole'],
          resources: ['arn:aws:iam::*:role/cdk-*']
        })
      ]
    });

    const accessRole = new iam.Role(this, 'aws-cdk-access-role', {
      assumedBy: principal,
      roleName: `${gitHub.RoleName}`,
      description: 'Role to allow access for GitHub Actions to deploy CDK stacks',
      inlinePolicies: {
        assumeRole: assumeRolePolicy
      }
    });

    Object.entries(tags).forEach((entry) => {
      const [key, value] = entry;
      cdk.Tags.of(scope).add(key, value);
    });

  }
}
