/*
 *  Creates a security group that describes security groups allowed to call a microservice.
 */

provider "aws" {
 access_key = "${var.aws_key}"
 secret_key = "${var.aws_secret_key}"
 region     = "${var.aws_region}"
}

resource "aws_security_group" "administratorSecurityGroup" {
  name = "${var.vpc_name} - Administrator Standard"
  description = "Allow tcp port 22 from anywhere - anything out"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "administratorSecurityGroup"
  }
}

resource "aws_security_group_rule" "allowHttp" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.administratorSecurityGroup.id}"
}

resource "aws_security_group_rule" "allowAllEgress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.administratorSecurityGroup.id}"
}
