# Module aws-vpc

This module creates a VPC in a specified region with the following six subnets:

* Public subnets (across three availability zones)
* Private subnets (across three availability zones)

## Public Subnets

Public subnets are for VMs that are exposed publicly through the internet.  Web Servers go here.

VMs in public subnets can access other VMs in any of the other Public or Private subnets.

Public subnets are tagged with "Scope=Public".

## Private Subnets

Private subnets are for VMs with guarded data such as database servers and AMQP servers. They aren't accessible from the internet.

VMs in Private subnets can access other VMs in any of the other Private subnets.

Public subnets are tagged with "Scope=Private".
