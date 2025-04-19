resource "aws_lb" "main" {
#   depends_on = [
#   aws_vpc.main,
#   aws_subnet.public[*],
#   aws_subnet.private[*]
# ]

  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_elb_sg.id]
  #subnets            = var.subnet_ids
  subnets = [ aws_subnet.public[0].id, aws_subnet.public[1].id ]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "blue" {
#   depends_on = [
#   aws_vpc.main,
#   aws_subnet.public[*],
#   aws_subnet.private[*]
# ]

  name     = "${var.app_name}-tg-b"
  port     = var.container_port
  protocol = "HTTP"
  #vpc_id   = var.vpc_id
  vpc_id = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_target_group" "green" {
#   depends_on = [
#   aws_vpc.main,
#   aws_subnet.public[*],
#   aws_subnet.private[*]
# ]

  name     = "${var.app_name}-tg-g"
  port     = var.container_port
  protocol = "HTTP"
  #vpc_id   = var.vpc_id
  vpc_id = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# ✅ UPDATED: HTTPS Listener should reference the validated cert
resource "aws_lb_listener" "https_forward" {
  depends_on = [ aws_acm_certificate_validation.valid, aws_acm_certificate.cert ]
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.valid.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

resource "aws_lb_listener" "tf_ecs_listener_green" {
  load_balancer_arn = aws_lb.main.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_security_group" "ecs_elb_sg" {
#   depends_on = [
#   aws_vpc.main,
#   aws_subnet.public[*],
#   aws_subnet.private[*]
# ]

  name        = "${var.app_name}-elb_sg"
  description = "ELB security group for ECS URL"
  #vpc_id      = var.vpc_id
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
