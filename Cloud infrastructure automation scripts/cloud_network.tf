// Create Web subnet routing table
resource "aws_route_table" "onlyflights-rt" {
  vpc_id = "${aws_vpc.onlyflights-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.onlyflights-igw.id}"
  }

  tags = {
    "Name" = "OnlyFlights Routing Table"
  }
}


// Assosiate routing tables to correct subnet
resource "aws_route_table_association" "fargate-subnet"{
    subnet_id = "${aws_subnet.fargate-subnet-1a.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "fargate-subnet-1b"{
    subnet_id = "${aws_subnet.fargate-subnet-1b.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "gitlab-subnet"{
    subnet_id = "${aws_subnet.gitlab-subnet.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "admin-subnet"{
    subnet_id = "${aws_subnet.admin-subnet.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "openvpn-subnet"{
    subnet_id = "${aws_subnet.openvpn-subnet-1a.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "rds-subnet-1a"{
    subnet_id = "${aws_subnet.rds-subnet-1a.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}

resource "aws_route_table_association" "rds-subnet-1b"{
    subnet_id = "${aws_subnet.rds-subnet-1b.id}"
    route_table_id = "${aws_route_table.onlyflights-rt.id}"
}