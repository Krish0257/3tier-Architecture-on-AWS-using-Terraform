resource "aws_secretsmanager_secret" "db" {
  name = "rds-db-credentials"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db.result
  })
}

locals {
  db_creds = {
    username = var.db_username
    password = random_password.db.result
  }
}