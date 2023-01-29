resource "aws_vpc" "onlyflights-vpc" {
  cidr_block = "10.11.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "OnlyFlights VPC"
  }
}