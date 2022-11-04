# resource "aws_vpn_connection" "services-to-infralab-vpn" {
#   transit_gateway_id = "${aws_ec2_transit_gateway.services-infralab-tgw.id}"
#   customer_gateway_id = "${aws_customer_gateway.services-infralab-cgw.id}"
#   static_routes_only = true
#   outside_ip_address_type = "PublicIpv4"
#   type = "ipsec.1"

#   tags = {
#     Name = "Services-to-InfraLab VPN"
#     Importance = "Transition"
#   }
# }