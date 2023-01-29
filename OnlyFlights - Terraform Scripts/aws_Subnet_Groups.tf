// Create subnet groups
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "onlyflights"
  subnet_ids = ["${aws_subnet.rds-subnet-1a.id}", "${aws_subnet.rds-subnet-1b.id}"]

  tags = {
    Name = "OnlyFlights Subnet Group"
  }
}