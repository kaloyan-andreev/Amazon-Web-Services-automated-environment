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


// Create GitRunner key pair

resource "aws_key_pair" "gitrunner-key-pair" {
  key_name   = "OnlyFlights_GitRunner_key_pair"
  public_key = "${tls_private_key.gitrunner-rsa-4096.public_key_openssh}"
}

// RSA key of size 4096 bits
resource "tls_private_key" "gitrunner-rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Store file on local machine
resource "local_file" "gitrunner-key_pair" {
    content  = "${tls_private_key.gitrunner-rsa-4096.private_key_pem}"
    filename = "OnlyFlights_GitRunner_key_pair.pem"
}


// Create OpenVPN key pair

resource "aws_key_pair" "openvpn-key-pair" {
  key_name   = "OnlyFlights_OpenVPN_key_pair"
  public_key = "${tls_private_key.openvpn-rsa-4096.public_key_openssh}"
}

// RSA key of size 4096 bits
resource "tls_private_key" "openvpn-rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Store file on local machine
resource "local_file" "openvpnkey_pair" {
    content  = "${tls_private_key.openvpn-rsa-4096.private_key_pem}"
    filename = "OnlyFlights_OpenVPN_key_pair.pem"
}