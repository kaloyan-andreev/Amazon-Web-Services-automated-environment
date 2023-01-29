// Create security group for the RDS
resource "aws_security_group" "rds-security-group" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH connection"
    }

    // Inbound rule for MYSQL/Aurora connection
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Connection with MySQL"
    }

    tags = {
        Name = "RDS Security Group"
    }
}

resource "aws_security_group" "gitlab-security-group" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH connection"
    }

    // Inbound rule for Prometheus conection
    ingress {
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Prometheus connection"
    }

    // Inbound rule for HTTP access
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP access"
    }

    tags = {
        Name = "GitLab-Runner Security Group"
    }
}

resource "aws_security_group" "admin-security-group" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH connection"
    }

    // Inbound rule for Prometheus connection
    ingress {
        from_port = 9090
        to_port = 9090
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Prometheus connection"
    }

    // Inbound rule for Grafana
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Grafana"
    }

    // Inbound rule for MYSQL/Aurora connection
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Connection to MySQL"
    }

    tags = {
        Name = "Admin's instance Security Group"
    }
}

resource "aws_security_group" "openvpn-security-group" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH connection"
    }

    // Inbound rule for Prometheus conection
    ingress {
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Prometheus connection"
    }

    // Inbound rule for MYSQL/Aurora connection
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Connection to MySQL"
    }

    // Inbound rule for openVPN client
    ingress {
        from_port = 943
        to_port = 943
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "OpenVPN client"
    }

    tags = {
        Name = "OpenVPN Security Group"
    }
}

resource "aws_security_group" "elb-security-group" {
    vpc_id = "${aws_vpc.onlyflights-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    // Inbound rule for SSH conection
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP"
    }

    // Inbound rule for MYSQL/Aurora connection
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS"
    }

    tags = {
        Name = "Application LoadBalancer Security Group"
    }
}