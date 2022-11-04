// Create peering connection
resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id = "${aws_vpc.web-vpc.id}"
  vpc_id = "${aws_vpc.services-vpc.id}"
  auto_accept = true

  tags = {
    "Name" = "Web-Services-PCX"
  }
}


// Create Web subnet routing table
resource "aws_route_table" "web-rt" {
  vpc_id = "${aws_vpc.web-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.web-igw.id}"
  }

  tags = {
    "Name" = "Web-RT"
  }
}

// Create Private subnet routing table 
resource "aws_route_table" "private-rt" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.services-igw.id}"
  }

  tags = {
    "Name" = "Private-RT"
  }
}

// Create Tech subnet routing table 
resource "aws_route_table" "tech-rt" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.services-igw.id}"
  }
  
  tags = {
    "Name" = "Tech-RT"
  }
}

// Create Utility subnet routing table 
resource "aws_route_table" "utility-rt" {
  vpc_id = "${aws_vpc.services-vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.services-igw.id}"
  }
  
  tags = {
    "Name" = "Utility-RT"
  }
}



// Assosiate routing tables to correct subnet
resource "aws_route_table_association" "web-rt-subnet"{
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.web-rt.id}"
}

resource "aws_route_table_association" "private-rt-subnet"{
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_route_table_association" "utility-rt-subnet"{
    subnet_id = "${aws_subnet.utility-subnet.id}"
    route_table_id = "${aws_route_table.utility-rt.id}"
}

resource "aws_route_table_association" "tech-rt-subnet"{
    subnet_id = "${aws_subnet.tech-subnet.id}"
    route_table_id = "${aws_route_table.tech-rt.id}"
}


// Add route to route table
resource "aws_route" "r1" {
  route_table_id = "${aws_route_table.web-rt.id}"
  destination_cidr_block = "10.2.4.0/24"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.foo.id}"
}


resource "aws_route" "r2" {
  route_table_id = "${aws_route_table.tech-rt.id}"
  destination_cidr_block = "10.1.1.0/24"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.foo.id}"
}
