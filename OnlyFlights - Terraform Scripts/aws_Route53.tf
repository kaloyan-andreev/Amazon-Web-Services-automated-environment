resource "aws_route53_zone" "hosted-zone" {
  name = "onlyflights.net"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.hosted-zone.id}"
  name    = "www"
  type    = "A"

  alias {
    evaluate_target_health = false
    name = "${aws_lb.onlyflights-alb.dns_name}"
    zone_id = "${aws_lb.onlyflights-alb.zone_id}"
  }
}

