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

resource "null_resource" "hostnames" {
  provisioner "local-exec" {
    command = "./get_hostname_info.sh"
  }
  depends_on = [helm_release.jenkins,helm_release.wapi]
}
