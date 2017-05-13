#!/bin/bash

#  Collects AWS key information

echo "AWS Key:"
read TF_VAR_aws_key

echo "AWS Secret Key:"
read TF_VAR_aws_secret_key

export TF_VAR_aws_key TF_VAR_aws_secret_key
