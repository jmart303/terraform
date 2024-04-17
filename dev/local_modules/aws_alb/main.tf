resource "aws_lb" "test_elb_v2" {
  name               = "test-elb-version-2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.aws_security_group_id}"]
  subnets            = ["${var.aws_subnet_id_1}", "${var.aws_subnet_id_2}"]

  enable_deletion_protection = false

  tags = {
    Key = "Owner"
    value = var.email
    propagate_at_launch = true
  }
}

resource "aws_lb_target_group" "test_elb_v2_tg" {
  name     = "testelbv2tg"
  protocol = "HTTP"
  port     = 8080
  vpc_id   = var.vpc_id

  health_check {
    port     = 8080
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "test_elb_v2_listener" {
  load_balancer_arn = aws_lb.test_elb_v2.id
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.test_elb_v2_tg.id
    type             = "forward"
  }
}