// Create security group for the public subnet
resource "aws_security_group" "public-subnet-security-group" {
    vpc_id = "${aws_vpc.web-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection from Tech Subnet
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.2.4.10/32"]
        description = "SSH connection from Admin EC2"
    }
    
    // Inbound rule for HTTP connection from the end users
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Open port 80 for flask app"
    }

    tags = {
        Name = "Public Subnet Security Group"
    }
}


// Create security group for Tech Subnet
resource "aws_security_group" "tech-subnet-security-group" {
    vpc_id = "${aws_vpc.services-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection from admin's local network
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["92.109.129.239/32"]
        description = "SSH connection from Admin local network"
    }

    tags = {
        Name = "Tech Subnet Security Group"
    }
}


// Create security group for Private subnet
resource "aws_security_group" "private-subnet-security-group" {
    vpc_id = "${aws_vpc.services-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection from Tech subnet
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.2.4.0/24"]
        description = "SSH connection from Tech Subnet"
    }

    // Inbound rule to open MySQL/Aurora port
        ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Open port 3306 for connection with MySQL Workbench"
    }

    tags = {
        Name = "Private Subnet Security Group"
    }
}


// Create security group for Utility subnet
resource "aws_security_group" "utility-subnet-security-group" {
    vpc_id = "${aws_vpc.services-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection from admin's instance
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.2.4.0/32"]
        description = "SSH connection from Tech Subnet"
    }

    tags = {
        Name = "Utility Subnet Security Group"
    }
}


// Create security group for the RDS
resource "aws_security_group" "rds-security-group" {
    vpc_id = "${aws_vpc.services-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection from Tech Subnet
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.2.4.0/24"]
        description = "SSH connection from Tech Subnet"
    }

    // Inbound rule for MYSQL/Aurora connection from the end users
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Open port 3306 for connection with MySQL Workbench"
    }

    tags = {
        Name = "RDS Security Group"
    }
}