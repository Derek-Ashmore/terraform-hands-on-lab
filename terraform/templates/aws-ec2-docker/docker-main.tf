/*
 * Defines and launches a ec2 instance running Docker into a private subnet.
 */

provider "aws" {
  access_key = "${var.aws_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "microservice" {
 ami           = "${data.aws_ami.linux_ami.id}"
 instance_type = "t2.micro"
 subnet_id  = "${var.subnet_id}"
 key_name = "${var.key_pair}"
 associate_public_ip_address = "${var.assignPublicIp}"
 private_ip = "${var.privateIp}"
 user_data = "${var.userData}"
 vpc_security_group_ids = ["${var.microserviceSecurityGroupId}"]

 tags {
   "Name" = "${var.instance_name} - ${var.subnet_name}"
 }

}
