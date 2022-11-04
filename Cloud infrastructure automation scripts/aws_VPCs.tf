// Build Web VPC 
resource "aws_vpc" "web-vpc" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Web VPC"
  }
}

// Build Services VPC
resource "aws_vpc" "services-vpc" {
  cidr_block = "10.2.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Services VPC"
  }
}