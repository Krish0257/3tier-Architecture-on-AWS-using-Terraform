resource "aws_db_subnet_group" "three_tier" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnet_ids

}

resource "aws_db_instance" "three_tier" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  multi_az             = true
  username             = local.db_creds.username
  password             = local.db_creds.password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.three_tier.name

}
