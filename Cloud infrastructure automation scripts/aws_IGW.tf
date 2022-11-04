# Create IGW in Web VPC
resource "aws_internet_gateway" "web-igw" {
    vpc_id = "${aws_vpc.web-vpc.id}"

    tags = {
        Name = "Web-IGW"
    }
}


// Create IGW in Services VPC
resource "aws_internet_gateway" "services-igw" {
    vpc_id = "${aws_vpc.services-vpc.id}"

    tags = {
        Name = "Services-IGW"
    }
}