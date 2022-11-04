# Create EC2 instance for the website
resource "aws_instance" "website" {
    # Amazon machine image
    ami = "ami-0b41652f00b442576"
    
    # Instance type
    instance_type = "t2.micro"
    
    # VPC
    subnet_id = "${aws_subnet.public-subnet.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.public-subnet-security-group.id}"]
    
    # the Public SSH key
    key_name = "ansible_key_pair"
    
    # IP address
    private_ip = "10.1.1.10"

    tags = {
        Name = "Website"
        Importance = "Production"
    }
}

# Assign EIP to EC2
resource "aws_eip" "website-elastipIp" {
  instance = "${aws_instance.website.id}"
  vpc      = true
}

