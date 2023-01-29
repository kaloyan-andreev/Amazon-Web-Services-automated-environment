// Create Adminkey pair

resource "aws_key_pair" "admin-key-pair" {
  key_name   = "OnlyFlights_Admin_key_pair"
  public_key = "${tls_private_key.admin-rsa-4096.public_key_openssh}"
}

// RSA key of size 4096 bits
resource "tls_private_key" "admin-rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Store file on local machine
resource "local_file" "admin-key_pair" {
    content  = "${tls_private_key.admin-rsa-4096.private_key_pem}"
    filename = "OnlyFlights_Admin_key_pair.pem"
}
