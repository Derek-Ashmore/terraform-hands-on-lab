# Defines Route tables for the VPC, beyond the default.

# Define Route table for public subnets to properly route internet traffic.
resource "aws_route_table" "publicSubnetsRouteTable" {
    vpc_id = "${aws_vpc.newVPC.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internetGateway.id}"
    }
    tags {
        Name = "${var.vpc_name}.publicSubnetsRouteTable"
    }
}

# Associate the route table to public subnets.
resource "aws_route_table_association" "publicRouteTableAssociation" {
  count = "${length(var.cidr_block_public_subnet_segment_suffix_list)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.publicSubnetsRouteTable.id}"
}
