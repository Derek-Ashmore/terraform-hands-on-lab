/*
 * Variables defined for the aws-ec2-docker module.
 */

variable "aws_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
	default = "us-east-1"
}

variable "vpc_id" {
	description = "AWS ID of the VPC"
}
variable "subnet_id" {
  description = "Subnet where the docker ec2 instance will be placed"
}
variable "instance_name" {
	default = "TerraformLab Microservice"
}
variable "subnet_name" {
	default = "TerraformLab.private0"
}
variable "privateIp" {
	description = "Private IP assigned to the microservice"
}
variable "key_pair" {
	description = "Key pair to use when launching instance"
  default = ""
}
variable "assignPublicIp" {
	description = "should a public IP be associated to the web server (True / False)"
	default = "False"
}
variable "userData" {
	description = "UserData bootstrap script that is used when the instance is launched"
	default = ""
}
variable "microserviceSecurityGroupId" {
  description = "Security group assigned to the microservice instance when it's launched"
}
