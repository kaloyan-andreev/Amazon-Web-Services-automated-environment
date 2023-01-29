resource "aws_acm_certificate" "cert" {
  domain_name       = "*.onlyflights.net"
  validation_method = "DNS"
  key_algorithm   = "RSA_2048"

  lifecycle {
    create_before_destroy = true
  }
}
