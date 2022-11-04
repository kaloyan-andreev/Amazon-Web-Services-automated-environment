// Generate subnet in Web VPC
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.web-vpc.id}"
  cidr_block = "10.1.1.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Public Subnet"
  }
}


// Genetate subnets in Services VPC
resource "aws_subnet" "private-subnet" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  cidr_block = "10.2.2.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Private Subnet 1a"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  cidr_block = "10.2.5.0/24"
  availability_zone = "eu-central-1b"
  
  tags = {
    Name = "Private Subnet 1b"
  }
}

resource "aws_subnet" "utility-subnet" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  cidr_block = "10.2.3.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Utility Subnet"
  }
}

resource "aws_subnet" "tech-subnet" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  cidr_block = "10.2.4.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Tech Subnet"
  }
}