// Create RDS Microsoft SQL Server instance
resource "aws_db_instance" "default" {
# Declaring RDS name
  identifier = "only-flights-database"

# Allocating the storage for database instance.
  allocated_storage    = 50

# Declaring the database engine and engine_version
  engine               = var.engine
  engine_version       = var.engine_version

# Declaring the instance class and storage type
  instance_class       = var.instance_class
  storage_encrypted = true
  
# Name of the database instance 
  db_name              = var.name

# User to connect the database instance 
  username             = var.username

# Password to connect the database instance 
  password             = var.password
  
# Declaring VPC secuity group, subnet groups and parameter group
  vpc_security_group_ids = [aws_security_group.rds-security-group.id]
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.name}"
  parameter_group_name = var.parameter_group_name

# Backup configuration
  backup_retention_period = 7
  backup_window = "19:00-20:00"
  delete_automated_backups = false

# Maintanence
  maintenance_window = "SUN:08:00-SUN:10:00"
  
# Multi Availability Zones
  multi_az = true

# Accessability
  publicly_accessible = false

# Snapshot option
  skip_final_snapshot = true
}