// Create EC2 instance for Tech subnet

// Admin's EC2 instance
resource "aws_instance" "admin" {
    // Amazon machine image
    ami = "ami-0b41652f00b442576"
    
    // Instance type
    instance_type = "t2.micro"
    
    // VPC
    subnet_id = "${aws_subnet.tech-subnet.id}"
    
    // Security Group
    vpc_security_group_ids = ["${aws_security_group.tech-subnet-security-group.id}"]
    
    // the Public SSH key
    key_name = "ansible_key_pair"
    
    // IP address
    private_ip = "10.2.4.10"

    tags = {
        Name = "Admin"
        Importance = "Maintenance"
    }
}

// Support's EC2 instance
resource "aws_instance" "support" {
    // Amazon machine image
    ami = "ami-0b41652f00b442576"
    
    // Instance type
    instance_type = "t2.micro"
    
    // VPC
    subnet_id = "${aws_subnet.tech-subnet.id}"
    
    // Security Group
    vpc_security_group_ids = ["${aws_security_group.tech-subnet-security-group.id}"]
    
    // the Public SSH key
    key_name = "ansible_key_pair"
    
    // IP address
    private_ip = "10.2.4.20"

    tags = {
        Name = "Support"
        Importance = "Maintenance"
    }
}



// Assign EIP to the instances

// EIP for Admin's EC2
resource "aws_eip" "admin-elastipIp" {
  instance = "${aws_instance.admin.id}"
  vpc      = true
}

// EIP for Support's EC2
resource "aws_eip" "support-elastipIp" {
  instance = "${aws_instance.support.id}"
  vpc      = true
}