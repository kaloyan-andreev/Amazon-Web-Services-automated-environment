resource "aws_instance" "gitlab-runner" {
    # Amazon machine image
    ami = "ami-08f4df18aa6f249eb"
    
    # Instance type
    instance_type = "t2.micro"
    
    # VPC
    subnet_id = "${aws_subnet.gitlab-subnet.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.gitlab-security-group.id}"]
    
    # the Public SSH key
    key_name = "OnlyFlights_GitRunner_key_pair"
    
    # IP address
    private_ip = "10.11.3.10"

    tags = {
        Name = "GitLab Runner"
        Importance = "Production"
    }
}

resource "aws_instance" "admin-instance" {
    # Amazon machine image
    ami = "ami-08f4df18aa6f249eb"
    
    # Instance type
    instance_type = "t2.micro"
    
    # VPC
    subnet_id = "${aws_subnet.admin-subnet.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.admin-security-group.id}"]
    
    # the Public SSH key
    key_name = "OnlyFlights_Admin_key_pair"
    
    # IP address
    private_ip = "10.11.4.10"

    tags = {
        Name = "Admin"
        Importance = "Monitoring"
    }
}

resource "aws_instance" "openvpn" {
    # Amazon machine image
    ami = "ami-08f4df18aa6f249eb"
    
    # Instance type
    instance_type = "t2.micro"
    
    # VPC
    subnet_id = "${aws_subnet.openvpn-subnet-1a.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.openvpn-security-group.id}"]
    
    # the Public SSH key
    key_name = "OnlyFlights_OpenVPN_key_pair"
    
    # IP address
    private_ip = "10.11.5.10"

    tags = {
        Name = "OpenVPN"
        Importance = "Backup"
    }
}
