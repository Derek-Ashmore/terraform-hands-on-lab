/*
 * aws-vpc - Terreform to create and configure an AWS VPC instance.
 *
 * The VPC has multiple subnets optionally spread across availability zones.
 *   public subnets - are accessible from the internet and are designed for firewalls.
 *   private subnets - are accessible from dmz subnets and contain resources like database servers and message queue servers.
 */

provider "aws" {
  access_key = "${var.aws_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# Define VPC
resource "aws_vpc" "newVPC" {
    cidr_block = "${var.cidr_block_prefix}.0.0${var.cidr_block_vpc_suffix}"

    tags {
        Name = "${var.vpc_name}"
    }
}

# Define three public subnets across different avaialbility zones. Firewalls go here.
# Public traffic allowed in; firewall determines/logs what passes beyond.
resource "aws_subnet" "public" {
  count = "${length(var.cidr_block_public_subnet_segment_suffix_list)}"
  vpc_id = "${aws_vpc.newVPC.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block = "${var.cidr_block_prefix}${var.cidr_block_public_subnet_segment_suffix_list[count.index]}"
  map_public_ip_on_launch = "true"

  tags {
      Name = "${var.vpc_name}.public${count.index}"
      Scope = "Public"
  }
}

# Define three private subnets across different availability zones. Database servers and other private resources go here.
# Resources here can only be accessed from dmz and private subnets.
resource "aws_subnet" "private" {
  count = "${length(var.cidr_block_private_subnet_segment_suffix_list)}"
  vpc_id = "${aws_vpc.newVPC.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block = "${var.cidr_block_prefix}${var.cidr_block_private_subnet_segment_suffix_list[count.index]}"

  tags {
      Name = "${var.vpc_name}.private${count.index}"
      Scope = "Private"
  }
}
