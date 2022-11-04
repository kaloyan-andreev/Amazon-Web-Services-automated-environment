// Create EC2 instance for Private subnet

// Chat Server
resource "aws_instance" "chat" {
    // Amazon machine image
    ami = "ami-0caef02b518350c8b"
    
    // Instance type
    instance_type = "t2.micro"
    
    // VPC
    subnet_id = "${aws_subnet.private-subnet.id}"
    
    // Security Group
    vpc_security_group_ids = ["${aws_security_group.private-subnet-security-group.id}"]
    
    // the Public SSH key
    key_name = "ansible_key_pair"
    
    // IP address
    private_ip = "10.2.2.20"

    tags = {
        Name = "Chat_Server"
        Importance = "Production"
    }
}