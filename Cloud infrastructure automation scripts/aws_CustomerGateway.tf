resource "aws_customer_gateway" "services-infralab-cgw" {
  bgp_asn    = 65000
  ip_address = "145.220.75.94"
  type       = "ipsec.1"

  tags = {
    Name = "Services-to-InfraLab Customer Gateway"
    Importance = "Transition"
  }
}