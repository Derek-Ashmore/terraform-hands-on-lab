rem  Prompts for AWS key/secret key to be used as environment variables.
rem  Note that environment variables for Terraform MUST be prefaced by "TF_VAR_"

echo off

set /p TF_VAR_aws_key="AWS Key:"
set /p TF_VAR_aws_secret_key="AWS Secret Key:"

echo TF_VAR_aws_key=%TF_VAR_aws_key%
echo TF_VAR_aws_secret_key=%TF_VAR_aws_secret_key%