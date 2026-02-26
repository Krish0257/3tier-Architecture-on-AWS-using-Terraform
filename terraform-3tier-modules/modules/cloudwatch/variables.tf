variable "asg_name" {
  type = string
}

variable "cpu_scale_out_threshold" {
  type    = number
  default = 70
}

variable "cpu_scale_in_threshold" {
  type    = number
  default = 30
}