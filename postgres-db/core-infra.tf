# --- 1. Database Credentials in Secrets Manager ---
resource "random_password" "master" {
  length  = 16
  special = false # Avoid characters that might break some connection strings
}

resource "aws_secretsmanager_secret" "db_secret" {
  name        = "aurora-db-credentials"
  description = "Aurora Postgres master credentials"
}

resource "aws_secretsmanager_secret_version" "db_secret_val" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "dbadmin"
    password = random_password.master.result
    engine   = "postgres"
    host     = aws_rds_cluster.aurora.endpoint
    port     = 5432
  })
}

# --- 2. Aurora Serverless v2 Cluster ---
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "app-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned" # V2 uses provisioned mode with serverless instances
  engine_version          = "15.4"
  database_name           = "myappdb"
  master_username         = "dbadmin"
  master_password         = random_password.master.result
  
  # Enable IAM Database Authentication
  iam_database_authentication_enabled = true
  
  db_subnet_group_name    = module.vpc.database_subnet_group
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true

  serverlessv2_scaling_configuration {
    max_capacity = 2.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
}