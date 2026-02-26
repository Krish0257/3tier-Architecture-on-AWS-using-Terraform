variable "vpc_id" {

}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ami_id" {

}

variable "instance_type" {

}

variable "target_group_arn" {

}

variable "ec2_sg_id" {
  type = string
}