resource "aws_security_group" "rds_sg" {
  name   = "rds-aurora-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    # Replace with your App's Security Group ID to restrict access
    security_groups = [aws_security_group.ecs_tasks_sg.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}