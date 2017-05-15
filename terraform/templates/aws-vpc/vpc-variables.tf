/*
 * Variables defined for the aws-vpc module.
 */

variable "aws_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
	default = "us-east-1"
}
variable "vpc_name" {
	description = "Name of the VPC"
}
variable "cidr_block_prefix" {
	description = "CIDR block prefix (two nodes) used by the VPC"
	default = "10.0"
}
variable "cidr_block_vpc_suffix" {
	description = "CIDR block suffix (including slash) used by the VPC"
	default = "/16"
}

variable "cidr_block_public_subnet_segment_suffix_list" {
  type    = "list"
	description = "CIDR block suffix (two nodes plus slash) for individual public subnets"
  default = [".0.0/24"]
}

variable "cidr_block_private_subnet_segment_suffix_list" {
  type    = "list"
	description = "CIDR block suffix (two nodes plus slash) for individual dmz subnets"
  default = [".20.0/24"]
}
