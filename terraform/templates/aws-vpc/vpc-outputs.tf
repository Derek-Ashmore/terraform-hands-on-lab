/*
 * Outputs defined for the aws-vpc module.
 */

output "VpcId" {
    value = "${aws_vpc.newVPC.id}"
}
