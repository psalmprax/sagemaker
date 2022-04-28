#!/bin/bash
echo bucket will be set shortly
bucket=aws-sam-cli-managed-default-samclisourcebucket-1jjo6r5tuotbj
# aws-sam-cli-managed-default-samclisourcebucket-1jjo6r5tuotbj
# oec-test-app-bucket
# CAPABILITY_IAM
# CAPABILITY_NAMED_IAM
# S3 Bucket not specified, use --s3-bucket to specify a bucket name, or use --resolve-s3 to create a managed default bucket, or run sam deploy --guided
stack_name=oec-test-app
region=eu-central-1
#cd $stack_name
echo "#!/bin/bash
cd oec-test-app
sudo sam build -u -m $PWD/Predict/requirements.txt
sudo sam package --s3-bucket $bucket --output-template-file $PWD/template_deploy.yaml --region $region
sudo sam deploy --s3-bucket $bucket --stack-name $stack_name --capabilities CAPABILITY_NAMED_IAM --region $region --no-disable-rollback  --no-confirm-changeset" > ../deploy.sh