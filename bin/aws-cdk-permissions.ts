#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { AwsCdkPermissionsStack } from '../lib/aws-cdk-permissions-stack';

const app = new cdk.App();
new AwsCdkPermissionsStack(app, 'AwsCdkPermissionsStack', {
  
  env: { account: process.env.AWS_ACCOUNT, region: process.env.AWS_REGION },

});

