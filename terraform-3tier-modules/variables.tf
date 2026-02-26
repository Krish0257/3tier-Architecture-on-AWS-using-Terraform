variable "aws_region" {
  type        = string
  description = "AWS region"
}
variable "vpc_cidr" {
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)

}
variable "ami_id" {

}

variable "instance_type" {

}

variable "db_username" {
  type = string

}

