resource "time_sleep" "sleep5s" {
  create_duration = "5s"

  depends_on = [ module.eks.aws_eks_cluster ]
}

resource "null_resource" "kubectl_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name inodev-coding-exercise --alias inodev-exercise"
  }
  depends_on = [ module.eks.aws_eks_cluster ]
}
resource "null_resource" "namespaces" {
  provisioner "local-exec" {
    command = "kubectl create ns jenkins && kubectl create ns wapi"
  }
  depends_on = [ module.eks.aws_eks_cluster, null_resource.kubectl_config, time_sleep.sleep5s ]
}

resource "helm_release" "jenkins" {
  provider = helm

  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"
  timeout    = 600
  values = [
    file("../helm/jenkins_release_values.yaml"),
   ]

   depends_on = [null_resource.namespaces]
 }

# resource "helm_release" "wapi" {
#   provider = helm

#   name       = "wapi"
#   # repository = "https://charts.jenkins.io"
#   chart      = "wapi"
#   namespace  = "wapi"
#   timeout    = 600
#   values = [
#     file("./helm_values_wapi.yaml"),
#   ]

#   depends_on = [null_resource.namespaces]
# }

# resource "null_resource" "run_post_provision_tasks" {
#   provisioner "local-exec" {
#     command = "ansible-playbook post_provision.yaml"
#     environment = {
#       ENV_KEY_1           = ENV_VAL_1
#       ENV_KEY_2          = ENV_VAL_2
#     }
#   }
# depends_on = [
#     azuread_application.app1
#   ]
# }