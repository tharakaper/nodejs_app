resource "aws_lb" "application-alb" {
  name               = "alb-${var.environment}-${var.application_name}"
  internal           = var.internal
  load_balancer_type = var. load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  #  enable_deletion_protection = var.del_protection

  access_logs {
    bucket  = var.bucket_name
    prefix  = var.dir_name

    enabled = var.log_enable
  }

  tags = var.tags
}

resource "aws_lb_listener" "front-end-http" {
  load_balancer_arn = aws_lb.application-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application-tg.arn
  }
}

variable "vpc_id" {
  default = ""
}
resource "aws_lb_target_group" "application-tg" {
  name        = "alb-tg-${var.environment}-${var.application_name}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path = "/index.html"
    port = 3000
  }
}

#resource "aws_lb_target_group_attachment" "pub-lb-attachment" {
#  count            = var.target_group_count
#  target_group_arn = aws_lb_target_group.application-tg.arn
  #  target_id        = var.target_id
#  target_id = element(var.target_id, count.index)
#  port      = 80
#}
