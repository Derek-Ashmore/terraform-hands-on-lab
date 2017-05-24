/*
 *  Creates a security group that describes security groups allowed to call a microservice.
 */

provider "aws" {
 access_key = "${var.aws_key}"
 secret_key = "${var.aws_secret_key}"
 region     = "${var.aws_region}"
}

resource "aws_security_group" "microserviceSecurityGroup" {
  name = "${var.vpc_name} - Microservice Standard"
  description = "Allow tcp port 80 from web servers in - anything out"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "microserviceSecurityGroup"
  }
}

resource "aws_security_group_rule" "allowHttp" {
  count = "${length(var.caller_security_group_id_list)}"
  type = "ingress"
  from_port = "${var.publishedCallerPort}"
  to_port = "${var.publishedCallerPort}"
  protocol = "tcp"
  source_security_group_id = "${var.caller_security_group_id_list[count.index]}"

  security_group_id = "${aws_security_group.microserviceSecurityGroup.id}"
}

resource "aws_security_group_rule" "allowAdminSSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    source_security_group_id = "${var.administratorSecurityGroupId}"

    security_group_id = "${aws_security_group.microserviceSecurityGroup.id}"
}

resource "aws_security_group_rule" "allowAllEgress" {
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.microserviceSecurityGroup.id}"
}
