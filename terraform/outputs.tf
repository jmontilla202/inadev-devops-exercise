output "oidc_provider" {
  value = module.eks.oidc_provider
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
