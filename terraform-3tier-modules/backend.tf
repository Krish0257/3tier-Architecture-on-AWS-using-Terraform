terraform {
  backend "s3" {
    bucket         = "terraform-prod-state-bucket-k"
    key            = "three_tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Terraform-lock"
    encrypt        = true
  }
}