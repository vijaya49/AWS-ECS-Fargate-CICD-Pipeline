resource "aws_security_group" "ecs_sg" {
#   depends_on = [
#   aws_vpc.main,
#   aws_subnet.public[*],
#   aws_subnet.private[*]
# ]

  name        = "${var.app_name}-sg"
  description = "Allow traffic to ECS tasks and ALB"
  # vpc_id      = var.vpc_id
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_elb_sg.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_elb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
