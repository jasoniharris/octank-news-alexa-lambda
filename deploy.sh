#!/usr/bin/env bash

ROLE=`aws cloudformation describe-stacks --stack-name stack01 --query "Stacks[0].Outputs[?OutputKey=='alexaskillskitnodejsfactskillRole'].OutputValue" --output text`

echo "ROLE is ${ROLE}"

sam package \
  --template-file template.yml \
  --output-template-file package.yml \
  --s3-bucket octank-news-alexa-lambda

sam deploy \
  --template-file package.yml \
  --stack-name octank-news-alexa-lambda \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides ROLE=$ROLE 