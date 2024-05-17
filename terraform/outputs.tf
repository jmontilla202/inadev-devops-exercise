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

# output "jenkins_url" {
#   value = "http://${kubernetes_service.jenkins.status.0.load_balancer.0.ingress.0.hostname}:8080"
# }

# output "wapi_app_url" {
#   value = "http://${kubernetes_service.wapi.status.0.load_balancer.0.ingress.0.hostname}:8080"
# }