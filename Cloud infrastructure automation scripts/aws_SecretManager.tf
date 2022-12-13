// Secret for database creadentials
resource "aws_secretsmanager_secret" "database-credentials" {
  name = "OnlyFlights_Database_Credentials"
}

resource "aws_secretsmanager_secret_version" "secret-1" {
    secret_id = "${aws_secretsmanager_secret.database-credentials.id}"
    secret_string = <<EOF
   {
    "username": "${var.username}",
    "password": "${var.password}"
   }
EOF
}

