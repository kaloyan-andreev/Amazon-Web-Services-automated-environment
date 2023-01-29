resource "aws_subnet" "fargate-subnet-1a" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.1.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Fargate Subnet 1a"
  }
}

resource "aws_subnet" "fargate-subnet-1b" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.2.0/24"
  availability_zone = "eu-central-1b"
  
  tags = {
    Name = "Fargate Subnet 1b"
  }
}

resource "aws_subnet" "gitlab-subnet" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.3.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "GitLab Runner Subnet"
  }
}

resource "aws_subnet" "admin-subnet" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.4.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "Admin's Subnet"
  }
}

resource "aws_subnet" "openvpn-subnet-1a" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.5.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "OpenVPN Subnet"
  }
}

resource "aws_subnet" "rds-subnet-1a" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.6.0/24"
  availability_zone = "eu-central-1a"
  
  tags = {
    Name = "RDS Subnet 1a"
  }
}

resource "aws_subnet" "rds-subnet-1b" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"
  cidr_block = "10.11.7.0/24"
  availability_zone = "eu-central-1b"
  
  tags = {
    Name = "RDS Subnet 1b"
  }
}