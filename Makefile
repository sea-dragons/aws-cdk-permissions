CDK_DEFAULT_ACCOUNT=<aws-account-number>
AWS_REGION=ap-southeast-2
PROFILE=<aws-profile>

STACK_NAME=AwsCdkPermissionsStack # DO NOT CHANGE

## Synth
synth: variables
	docker-compose run --rm awscdk sh -c 'cdk synth ${STACK_NAME}'
.PHONY: synth

## Deploy
deploy: variables
	docker-compose run --rm awscdk sh -c '\
		CDK_DEFAULT_ACCOUNT=${CDK_DEFAULT_ACCOUNT} \
		AWS_REGION=${AWS_REGION} \
		PROFILE=${PROFILE} \
		cdk deploy ${STACK_NAME} \
		--require-approval never \
		--profile ${PROFILE}'
.PHONY: deploy

## DeployManual
deployManual: variables
	docker-compose run --rm awscdk sh -c '\
		CDK_DEFAULT_ACCOUNT=${CDK_DEFAULT_ACCOUNT} \
		AWS_REGION=${AWS_REGION} \
		PROFILE=${PROFILE} \
		cdk deploy ${STACK_NAME} \
		--profile ${PROFILE}'
.PHONY: deployManual

## Destroy
destroy: variables
	docker-compose run --rm awscdk sh -c '\
		CDK_DEFAULT_ACCOUNT=${CDK_DEFAULT_ACCOUNT} \
		AWS_REGION=${AWS_REGION} \
		PROFILE=${PROFILE} \
		cdk destroy ${STACK_NAME} \
		--force \
    	--profile ${PROFILE}'
.PHONY: destroy

## DestroyManual
destroyManual: variables
	docker-compose run --rm awscdk sh -c '\
		CDK_DEFAULT_ACCOUNT=${CDK_DEFAULT_ACCOUNT} \
		AWS_REGION=${AWS_REGION} \
		PROFILE=${PROFILE} \
		cdk destroy ${STACK_NAME} \
    	--profile ${PROFILE}'
.PHONY: destroyManual

## Variables
variables:
	touch .env
	docker-compose run --rm envvars validate
	docker-compose run --rm envvars envfile --overwrite
.PHONY: variables
