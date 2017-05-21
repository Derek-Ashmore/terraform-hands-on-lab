

# Lookup the VPC that the web server will be placed in.
data "aws_vpc" "targetVpc" {
   id = "${var.vpc_id}"
}
