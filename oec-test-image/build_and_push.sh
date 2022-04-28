#!/bin/bash

# Name of algo -> ECR
algorithm_name=sm-pretrained-spacy

# cd container

#make serve executable
chmod +x model/serve

account=$(aws sts get-caller-identity --query Account --output text)

# Region, defaults to us-west-2
region=$(aws configure get region)
region=${region:-us-east-1}

fullname="${account}.dkr.ecr.${region}.amazonaws.com/${algorithm_name}:latest"
echo ${fullname}
# If the repository doesn't exist in ECR, create it.
aws ecr describe-repositories --repository-names "${algorithm_name}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    sudo aws ecr create-repository --repository-name "${algorithm_name}" > /dev/null
fi

# Get the login command from ECR and execute it directly
# aws ecr get-login-password --region ${region}|docker login --username AWS --password-stdin ${fullname}
sudo aws ecr get-login-password --region ${region}|sudo docker login --username AWS --password-stdin ${fullname}
# sudo docker login -u AWS -p $(aws ecr get-login-password --region ${region}) ${fullname}

# docker login -u AWS -p $(aws ecr get-login-password --region ${region}) ${fullname}
# Build the docker image locally with the image name and then push it to ECR
# with the full name.

sudo docker build  -t ${algorithm_name} .
sudo docker tag ${algorithm_name} ${fullname}

sudo docker push ${fullname}