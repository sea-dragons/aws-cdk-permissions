STACK_NAME=AwsCdkPermissionsStack

## Bootstrap
bootstrap: variables
	docker-compose run --rm awscdk sh -c 'cdk bootstrap aws://$(AWS_ACCOUNT)/$(AWS_REGION) --profile $(PROFILE)'
.PHONY: bootstrap

## Synth
synth: variables
	docker-compose run --rm awscdk sh -c 'cdk synth ${STACK_NAME}'
.PHONY: synth

## Deploy
deploy: variables bootstrap
	docker-compose run --rm awscdk sh -c '\
		AWS_ACCOUNT=$(AWS_ACCOUNT) \
		AWS_REGION=$(AWS_REGION) \
		PROFILE=$(PROFILE) \
		cdk deploy ${STACK_NAME} \
		--require-approval never \
		--profile $(PROFILE)'
.PHONY: deploy

## DeployManual
deployManual: variables
	docker-compose run --rm awscdk sh -c '\
		AWS_ACCOUNT=$(AWS_ACCOUNT) \
		AWS_REGION=$(AWS_REGION) \
		PROFILE=$(PROFILE) \
		cdk deploy ${STACK_NAME} \
		--profile $(PROFILE)'
.PHONY: deployManual

## Destroy
destroy: variables
	docker-compose run --rm awscdk sh -c '\
		AWS_ACCOUNT=$(AWS_ACCOUNT) \
		AWS_REGION=$(AWS_REGION) \
		PROFILE=$(PROFILE) \
		cdk destroy ${STACK_NAME} \
		--force \
    	--profile $(PROFILE)'
.PHONY: destroy

## DestroyManual
destroyManual: variables
	docker-compose run --rm awscdk sh -c '\
		AWS_ACCOUNT=$(AWS_ACCOUNT) \
		AWS_REGION=$(AWS_REGION) \
		PROFILE=$(PROFILE) \
		cdk destroy ${STACK_NAME} \
    	--profile $(PROFILE)'
.PHONY: destroyManual

## Variables
variables:
	touch .env
	docker-compose run --rm envvars validate
	docker-compose run --rm envvars envfile --overwrite
.PHONY: variables
