resource "null_resource" "db_setup" {
  # This runs after the DB is fully created and available
  depends_on = [aws_rds_cluster_instance.aurora_instances]

  provisioner "local-exec" {
    command = <<EOF
      export PGPASSWORD='${random_password.master.result}'

      # Run standard SQL scripts first (exclude mocks)
      for f in ${path.module}/sql/*.sql; do
        [ -e "$f" ] || continue
        case "$f" in
          *"mock"*) continue ;;
          *) echo "Running $f"; psql -h ${aws_rds_cluster.aurora.endpoint} -U dbadmin -d myappdb -f "$f" ;;
        esac
      done

      # Run mock scripts last
      for f in ${path.module}/sql/*.sql; do
        [ -e "$f" ] || continue
        case "$f" in
          *"mock"*) echo "Running $f"; psql -h ${aws_rds_cluster.aurora.endpoint} -U dbadmin -d myappdb -f "$f" ;;
        esac
      done
    EOF
  }

  triggers = {
    # Re-run if any SQL file in the directory changes
    dir_sha = sha256(join("", [for f in sort(tolist(fileset("${path.module}/sql", "*.sql"))) : filesha256("${path.module}/sql/${f}")]))
  }
}