// Create subnet groups
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "main"
  subnet_ids = ["${aws_subnet.private-subnet.id}", "${aws_subnet.private-subnet-1b.id}"]

  tags = {
    Name = "OnlyFlights subnet group"
  }
}