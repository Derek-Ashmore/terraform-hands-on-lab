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

# End point 1
module "admin-security-group" {
  source  = "../../templates/security-groups/administrator"
	aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	vpc_id = "${module.aws-vpc.VpcId}"
}

module "webServer-security-group" {
  source  = "../../templates/security-groups/webServer"
	aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	vpc_id = "${module.aws-vpc.VpcId}"
	administratorSecurityGroupId = "${module.admin-security-group.administratorSecurityGroupId}"
}

module "aws-web-server" {
  source  = "../../templates/aws-web-server"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	key_pair = "TerraformKeyPair"

  vpc_id = "${module.aws-vpc.VpcId}"
  subnet_id = "${module.aws-vpc.publicSubnetIds[0]}"
  instance_name = "Lab Web Server"
  #userData = "${file("webServerBootstrapNoMicroservice.txt")}"
	userData = "${file("webServerBootstrap.txt")}"
	webServerSecurityGroupId = "${module.webServer-security-group.webServerSecurityGroupId}"
}

output "PublicIP" {
    value = "${module.aws-web-server.PublicIP}"
}

# End point 2
module "microservice-security-group" {
  source  = "../../templates/security-groups/microservice"
	aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	vpc_id = "${module.aws-vpc.VpcId}"
	caller_security_group_id_list = ["${module.webServer-security-group.webServerSecurityGroupId}"
		, "${module.admin-security-group.administratorSecurityGroupId}"]
	administratorSecurityGroupId = "${module.admin-security-group.administratorSecurityGroupId}"
}

module "aws-ec2-docker" {
  source  = "../../templates/aws-ec2-docker"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	key_pair = "TerraformKeyPair"

  vpc_id = "${module.aws-vpc.VpcId}"
  subnet_id = "${module.aws-vpc.privateSubnetIds[0]}"
  instance_name = "Lab Microservice"
  userData = "${file("microserviceBootstrap.txt")}"
	privateIp = "10.0.20.254"
	microserviceSecurityGroupId = "${module.microservice-security-group.microserviceSecurityGroupId}"
}

module "aws-jumpbox" {
  source  = "../../templates/aws-jump-box"
  aws_key = "${var.aws_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"

	key_pair = "TerraformKeyPair"

  vpc_id = "${module.aws-vpc.VpcId}"
  subnet_id = "${module.aws-vpc.publicSubnetIds[0]}"
  instance_name = "Lab Jump Box"
	administratorSecurityGroupId = "${module.admin-security-group.administratorSecurityGroupId}"
} /*
*/
