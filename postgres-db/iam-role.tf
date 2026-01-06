resource "aws_iam_role" "app_db_access_role" {
  name = "app-db-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" } # Allow ECS Tasks to use this
    }]
  })
}

resource "aws_iam_policy" "db_auth_policy" {
  name = "RDS_IAM_Auth_Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = "rds-db:connect"
      Effect   = "Allow"
      # Format: arn:aws:rds-db:region:account:dbuser:DbiResourceId/db_user_name
      Resource = "arn:aws:rds-db:${var.region}:${var.account_id}:dbuser:${aws_rds_cluster.aurora.cluster_resource_id}/dbadmin"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "db_auth_attach" {
  role       = aws_iam_role.app_db_access_role.name
  policy_arn = aws_iam_policy.db_auth_policy.arn
}