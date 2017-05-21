
output "webServerSecurityGroupId" {
    value = "${aws_security_group.webServerSecurityGroup.id}"
}
