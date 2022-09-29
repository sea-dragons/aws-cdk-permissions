FROM node:18

WORKDIR /work

RUN apt-get update && apt-get install -y

RUN npm install -g aws-cdk

VOLUME [ "/root/.aws" ]

WORKDIR /work
