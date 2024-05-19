output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "jenkins_status" {
  value = helm_release.jenkins.status
}

output "wapi_status" {
  value = helm_release.wapi.status
}

output "jenkins_url" {
  value = local.jenkins_lb
}

output "wapi_url" {
  value = local.wapi_lb
}