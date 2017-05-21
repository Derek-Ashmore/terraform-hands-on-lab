/*
 * Variables defined for the aws-web-server module.
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
	description = "Subnet where the web server will be placed"
}
variable "instance_name" {
	default = "TerraformLab Webserver"
}
variable "key_pair" {
	description = "Key pair to use when launching instance"
  default = ""
}
variable "assignPublicIp" {
	description = "should a public IP be associated to the web server (True / False)"
	default = "True"
}
variable "userData" {
	description = "UserData bootstrap script that is used when the instance is launched"
	default = ""
}
