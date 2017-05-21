# Provides needed Internet and Nat Gateways

# Defines an internet gateway for the VPC so that instances can receive internet traffic.
resource "aws_internet_gateway" "internetGateway" {
    vpc_id = "${aws_vpc.newVPC.id}"
    tags {
        Name = "${var.vpc_name}.internetGateway"
    }
}

# Elastic IP for nat gateway
resource "aws_eip" "natElasticIp" {
  vpc      = true
}

resource "aws_nat_gateway" "natGateway" {
  allocation_id = "${aws_eip.natElasticIp.id}"
  subnet_id  = "${element(aws_subnet.public.*.id, 0)}"
  depends_on = ["aws_internet_gateway.internetGateway"]
}
