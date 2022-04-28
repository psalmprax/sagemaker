#!/bin/bash
# https://aws.amazon.com/premiumsupport/knowledge-center/iam-assume-role-cli/
# https://stackoverflow.com/questions/63241009/aws-sts-assume-role-in-one-command
# https://www.learnaws.org/2022/02/05/aws-cli-assume-role/
# https://stackoverflow.com/questions/2440414/how-can-i-retrieve-the-first-word-of-the-output-of-a-command-in-bash
assume_role=$(aws sts assume-role --role-arn arn:aws:iam::594382077651:role/zulhke-migration-to-oec --role-session-name Admin --region eu-central-1 --query Credentials --output text)
assume_role=$(aws sts assume-role --role-arn arn:aws:iam::594382077651:role/zulhke-migration-to-oec --role-session-name Admin --region eu-central-1 --query Credentials --output text)
set -- $assume_role
export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$3
export AWS_SESSION_TOKEN=$4
aws sts get-caller-identity
unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
aws sts get-caller-identity