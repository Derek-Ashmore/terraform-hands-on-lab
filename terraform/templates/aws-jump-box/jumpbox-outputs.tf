/*
 * Outputs defined for the aws-web-server module.
 */

 output "PublicIP" {
     value = "${aws_instance.jumpbox.public_ip}"
 }
 output "PublicDNS" {
     value = "${aws_instance.jumpbox.public_dns}"
 }
