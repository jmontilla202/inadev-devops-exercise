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

   depends_on = [null_resource.namespaces,time_sleep.sleep5s]
 }

resource "helm_release" "wapi" {

  name       = "wapi"
  chart      = "../helm/wapi"
  namespace  = "wapi"
  timeout    = 600

  depends_on = [null_resource.namespaces, helm_release.jenkins, time_sleep.wait_10_seconds]
}
