# AWS CDK Permissions

![](https://img.shields.io/github/v/release/sea-dragons/aws-cdk-permissions?style=plastic)
![](https://img.shields.io/github/license/sea-dragons/aws-cdk-permissions?style=plastic)
![](https://img.shields.io/github/package-json/dependency-version/sea-dragons/aws-cdk-permissions/aws-cdk-lib?style=plastic)

This repository allows you to use AWS CDK to automate the creation of a role that GitHub Actions can assume to automatically deploy further AWS infrastructure. This requires that docker is running and that an AWS profile is setup with the required config/credentials files created.

The role name defaults to `aws-cdk-access-role` which then can be added to the GitHub Actions workflows. This, alongside other variables can be found in the `lib/account-details.json` file. The default tags to apply to the role cam be found in the `lib/default-tags.json` file.

The `lib/account-details.json` is required to be in the following structure:

```
{
  "RoleName": "aws-cdk-access-role",
  "GitHubOrgs": [
    // array of organisations
    {
      "OrgName": "<github-organisation>",
      "OrgRepos": [
        // array of repositories
        {
          "RepoName": "<github-repository>",
          "RepoEnvs": ["<github-environment>"], // array of environments
          "RepoBranches": ["<github-branch>"] // array of branches
        }
      ]
    }
  ]
}
```

The following commands can be run to deploy/destroy the role:

```
make deploy AWS_ACCOUNT=<aws-account> AWS_REGION=<aws-region> PROFILE=<aws-profile>
make destroy AWS_ACCOUNT=<aws-account> AWS_REGION=<aws-region> PROFILE=<aws-profile>
```

Other commands found in the `Makefile` are `make synth`, as well as `make deployManual` and `make destroyManual` to include the manual check before the deploy/destroy happens.
