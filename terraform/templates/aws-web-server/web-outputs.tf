/*
 * Outputs defined for the aws-web-server module.
 */

 output "PublicIP" {
     value = "${aws_instance.webServer.public_ip}"
 }
 output "webServerSecurityGroupId" {
     value = "${aws_security_group.webServerSecurityGroup.id}"
 }
 output "PublicDNS" {
     value = "${aws_instance.webServer.public_dns}"
 }
