resource "aws_ec2_transit_gateway" "services-infralab-tgw" {
    tags = {
      Name = "Services-to-InfraLab Transit Gateway"
      Importance = "Transition"
    }

    default_route_table_association = "disable"
    default_route_table_propagation = "disable"
}