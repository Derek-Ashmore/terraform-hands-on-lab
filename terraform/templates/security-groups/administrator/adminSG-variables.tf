

variable "aws_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
 default = "us-east-1"
}

variable "vpc_id" {
  description = "AWS ID of the VPC"
}

variable "vpc_name" {
  description = "Name tag of the VPC"
}
