#!/usr/bin/env bash

ROLE=`aws cloudformation describe-stacks --stack-name wedding-infrastructure --query "Stacks[0].Outputs[?OutputKey=='IAMLambdaServiceRole'].OutputValue" --output text --profile jh-pipeline`

echo "ROLE is ${ROLE}"

sam package \
  --template-file template.yml \
  --output-template-file package.yml \
  --s3-bucket harris-wedding-lambda-store \
  --profile jh-pipeline

sam deploy \
  --template-file package.yml \
  --stack-name harris-wedding-lambda-store \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides ROLE=$ROLE \
  --profile jh-pipeline