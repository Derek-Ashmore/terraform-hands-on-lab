# Provides needed Internet and Nat Gateways

# Defines an internet gateway for the VPC so that instances can receive internet traffic.
resource "aws_internet_gateway" "internetGateway" {
    vpc_id = "${aws_vpc.newVPC.id}"
    tags {
        Name = "${var.vpc_name}.internetGateway"
    }
}
