variable "region" {
  type = string
  default = "us-east-2"
}

variable "azs" {
  type = list(string)
  default = ["us-east-2a","us-east-2b"]
}

variable "vpc_cidr" {
  type = string
  default = "172.27.0.0/16"
}

variable "env" {
  type = string
  default = "dev"
}

variable "eks_version" {
    type = string
    default =   "1.29"
  
}