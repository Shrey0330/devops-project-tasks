variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "devops-interview"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  
  description = "EC2 Key pair name"
}