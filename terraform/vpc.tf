locals {
  name   = "inodev-coding-exercise"
  region = "${var.region}"

  vpc_cidr = var.vpc_cidr
  vpc_cidr_public   =   "172.27.16.0/20"
  vpc_cidr_private   =   "172.27.32.0/20"

  azs      = var.azs

  tags = {
    name    = "wtw-vpc"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr_private , 4, k)]
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr_public , 4, k)]

  enable_nat_gateway     = true
#   single_nat_gateway     = true
#   one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    env = var.env
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id1" {
  value = module.vpc.private_subnets[0]
}

output "private_subnet_id2" {
  value = module.vpc.private_subnets[1]
}