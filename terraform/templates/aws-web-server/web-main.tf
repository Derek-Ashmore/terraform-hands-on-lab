/*
 * Defines and launches a web-server into a public subnet.
 */

 provider "aws" {
    access_key = "${var.aws_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
  }

  resource "aws_security_group" "webServerSecurityGroup" {
    name = "${data.aws_vpc.targetVpc.tags.Name} - Web Server Standard"
    description = "Allow tcp port 80 in - anything out"
    vpc_id = "${var.vpc_id}"
  }

  resource "aws_security_group_rule" "allowHttp" {
      type = "ingress"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

      security_group_id = "${aws_security_group.webServerSecurityGroup.id}"
  }

  resource "aws_security_group_rule" "allowAllEgress" {
      type = "egress"
      from_port = 0
      to_port = 65535
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

      security_group_id = "${aws_security_group.webServerSecurityGroup.id}"
  }

  resource "aws_instance" "webServer" {
   ami           = "${data.aws_ami.linux_ami.id}"
   instance_type = "t2.micro"
   subnet_id  = "${var.subnet_id}"
   key_name = "${var.key_pair}"
   associate_public_ip_address = "${var.assignPublicIp}"
   user_data = "${var.userData}"
   vpc_security_group_ids = ["${aws_security_group.webServerSecurityGroup.id}"]

   tags {
     "Name" = "${var.instance_name} - ${data.aws_subnet.targetSubnet.tags.Name}"
   }

 }
