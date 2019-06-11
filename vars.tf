variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnets_cidr" {
  type    = "list"
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "az" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

variable "web_ami" {
  default = "ami-0c6b1d09930fac512"
}

variable "ins_type" {
  default = "t2.micro"
}
