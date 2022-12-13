resource "aws_lb" "onlyflights-alb" {
  name = "OnlyFlights-ApplicationLB"
  internal = false
  load_balancer_type = "application"
  subnets = ["${aws_subnet.fargate-subnet-1a.id}", "${aws_subnet.fargate-subnet-1b.id}"]
  security_groups = ["${aws_security_group.elb-security-group.id}"]
}


resource "aws_lb_listener" "onlyflights-port80-listeners" {
  load_balancer_arn = "${aws_lb.onlyflights-alb.arn}"

  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"
    
    redirect {
        port = 443
        protocol = "HTTPS"
        status_code = "HTTP_301"    
    }

  }
}

resource "aws_lb_listener" "onlyflights-port443-listeners" {
  load_balancer_arn = "${aws_lb.onlyflights-alb.arn}"

  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:eu-central-1:153658864904:certificate/c09b7367-b1ad-4b6a-b0cf-373d51ab3519"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.onlyflights-ip-target-group.arn}"

  }
}