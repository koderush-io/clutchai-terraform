resource "null_resource" "db_setup" {
  # This runs after the DB is fully created and available
  depends_on = [aws_rds_cluster_instance.aurora_instances]

  provisioner "local-exec" {
    command = <<EOF
      PGPASSWORD='${random_password.master.result}' psql \
      -h ${aws_rds_cluster.aurora.endpoint} \
      -U dbadmin -d myappdb \
      -f ${path.module}/sql/init.sql
    EOF
  }

  triggers = {
    # Only run once, or when the script file changes
    script_hash = filebase64sha256("${path.module}/sql/init.sql")
  }
}