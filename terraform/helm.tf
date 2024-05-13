resource "time_sleep" "sleep5s" {
  create_duration = "5s"

  depends_on = [ module.eks.aws_eks_cluster ]
}

resource "helm_release" "jenkins" {
  provider = helm

  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"
  timeout    = 600
  values = [
    file("../helm/jenkins/values.yaml"),
  ]

  depends_on = [null_resource.create_jenkins_namespace]
}

# resource "kubernetes_namespace" "jenkins" {
#   provider = kubernetes
#   metadata {
#     name = "jenkins"

#     labels = {
#       name        = "jenkins"
#       description = "jenkins"
#     }
#   }
#   wait_for_default_service_account = true
#   depends_on = [ module.eks.aws_eks_cluster, null_resource.kubectl_config, time_sleep.sleep10s]
# }

