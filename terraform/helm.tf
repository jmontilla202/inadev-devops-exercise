
data "external" "get_hostname_jenkins" {
  program = ["bash", "get_hostname_jenkins.sh"]
  depends_on = [module.eks.aws_eks_cluster]
}

data "external" "get_hostname_wapi" {
  program = ["bash", "get_hostname_wapi.sh"]
  depends_on = [module.eks.aws_eks_cluster]
}

locals {
  jenkins_lb      = "${data.external.get_hostname_jenkins}"
  wapi_lb = "${data.external.get_hostname_wapi}"
}
resource "null_resource" "kubectl_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name inodev-coding-exercise --alias inodev-exercise"
  }
  depends_on = [module.eks.aws_eks_cluster]
}
resource "null_resource" "namespaces" {
  provisioner "local-exec" {
    command = "kubectl create ns jenkins && kubectl create ns wapi"
  }
  depends_on = [null_resource.kubectl_config]
}

resource "null_resource" "wapi_role" {
  provisioner "local-exec" {
    command = "kubectl apply -f ../helm/wapi-deploy-permissions.yaml"
  }
  depends_on = [null_resource.kubectl_config]
}

resource "helm_release" "jenkins" {
  provider = helm

  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "jenkins"
  timeout    = 300
  values = [
    file("../helm/jenkins_release_values.yaml"),
   ]

   depends_on = [null_resource.namespaces, aws_eks_addon.ebs-csi-driver]
 }

resource "helm_release" "wapi" {

  name       = "wapi"
  chart      = "../helm/wapi"
  namespace  = "wapi"
  timeout    = 180

  depends_on = [ null_resource.namespaces, aws_eks_addon.ebs-csi-driver ]
}
