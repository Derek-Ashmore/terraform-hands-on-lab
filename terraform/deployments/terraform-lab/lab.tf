# This is the Terraform Lab
#
# Prerequisites -- set environment variables with AWS keys
#   Windows     Execute '..\..\setkeys'
#   Linux/Mac   Execute '../../setkeys.sh'

variable "aws_key" {}             # Environment Variable 'TF_VAR_aws_key'
variable "aws_secret_key" {}      # Environment Variable 'TF_VAR_aws_secret_key'
variable "aws_region" {
	default = "us-east-1"
}

# Define a VPC with public and private subnets.
module "aws-vpc" {
  source  = "../../templates/aws-vpc"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

  vpc_name = "TerraformLabVPC"
}

module "aws-web-server" {
  source  = "../../templates/aws-web-server"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

  vpc_id = "${module.aws-vpc.VpcId}"
  subnet_id = "${module.aws-vpc.publicSubnetIds[0]}"
  instance_name = "Lab Web Server"
  userData = "${file("webServerBootstrap.txt")}"
}

module "microservice-security-group" {
  source  = "../../templates/security-groups/microservice"
	aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	vpc_id = "${module.aws-vpc.VpcId}"
	caller_security_group_id_list = ["${module.aws-web-server.webServerSecurityGroupId}"]
}

module "aws-ec2-docker" {
  source  = "../../templates/aws-ec2-docker"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

  vpc_id = "${module.aws-vpc.VpcId}"
  subnet_id = "${module.aws-vpc.privateSubnetIds[0]}"
  instance_name = "Lab Microservice"
  userData = "${file("webServerBootstrap.txt")}"
	privateIp = "10.0.20.254"
	microserviceSecurityGroupId = "${module.microservice-security-group.microserviceSecurityGroupId}"
}

output "PublicIP" {
    value = "${module.aws-web-server.PublicIP}"
}
