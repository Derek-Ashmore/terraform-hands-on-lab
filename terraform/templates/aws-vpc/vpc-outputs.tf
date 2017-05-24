/*
 * Outputs defined for the aws-vpc module.
 */

output "VpcId" {
    value = "${aws_vpc.newVPC.id}"
}
output "VpcName" {
    value = "${aws_vpc.newVPC.tags.Name}"
}
output "publicSubnetIds" {
  value = ["${aws_subnet.public.*.id}"]
}
output "privateSubnetIds" {
  value = ["${aws_subnet.private.*.id}"]
}
