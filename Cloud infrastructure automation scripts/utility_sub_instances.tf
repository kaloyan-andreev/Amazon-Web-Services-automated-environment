// Create EC2 instance for Utility subnet

// BackUp Server
resource "aws_instance" "backup" {
    // Amazon machine image
    ami = "ami-0caef02b518350c8b"
    
    // Instance type
    instance_type = "t2.micro"
    
    // VPC
    subnet_id = "${aws_subnet.utility-subnet.id}"
    
    // Security Group
    vpc_security_group_ids = ["${aws_security_group.utility-subnet-security-group.id}"]
    
    // the Public SSH key
    key_name = "ansible_key_pair"
    
    // IP address
    private_ip = "10.2.3.20"

    tags = {
        Name = "BackUp_Server"
        Importance = "Storage"
    }
}

// Monitorring EC2 instance
resource "aws_instance" "zabbix" {
    // Amazon machine image
    ami = "ami-0caef02b518350c8b"
    
    // Instance type
    instance_type = "t2.micro"
    
    // VPC
    subnet_id = "${aws_subnet.utility-subnet.id}"
    
    // Security Group
    vpc_security_group_ids = ["${aws_security_group.utility-subnet-security-group.id}"]
    
    // the Public SSH key
    key_name = "ansible_key_pair"
    
    // IP address
    private_ip = "10.2.3.10"

    tags = {
        Name = "Zabbix_Server"
        Importance = "Maintenance"
    }
}