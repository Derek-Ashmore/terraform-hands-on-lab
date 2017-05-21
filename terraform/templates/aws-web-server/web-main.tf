/*
 * Defines and launches a web-server into a public subnet.
 */

 provider "aws" {
  access_key = "${var.aws_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "webServer" {
 ami           = "${data.aws_ami.linux_ami.id}"
 instance_type = "t2.micro"
 subnet_id  = "${var.subnet_id}"
 key_name = "${var.key_pair}"
 associate_public_ip_address = "${var.assignPublicIp}"
 user_data = "${var.userData}"
 vpc_security_group_ids = ["${var.webServerSecurityGroupId}"]

 tags {
   "Name" = "${var.instance_name} - ${data.aws_subnet.targetSubnet.tags.Name}"
 }

}
