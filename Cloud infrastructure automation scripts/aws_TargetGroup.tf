resource "aws_lb_target_group" "onlyflights-ip-target-group" {
  name        = "onlyflgihts-targetgroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${aws_vpc.onlyflights-vpc.id}"
  
  health_check {
    protocol = "HTTP"
    path = "/"
    matcher = 302
    unhealthy_threshold = 2
    healthy_threshold = 5
    timeout = 5
  }
}