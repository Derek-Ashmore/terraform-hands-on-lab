/*
 * Outputs defined for the aws-vpc module.
 */

output "VpcId" {
    value = "${aws_vpc.newVPC.id}"
}
output "publicSubnetIds" {
  value = ["${aws_subnet.public.*.id}"]
}
output "privateSubnetIds" {
  value = ["${aws_subnet.private.*.id}"]
}
