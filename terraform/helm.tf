# resource "helm_release" "jenkins" {
#   provider = helm

#   name       = "jenkins"
#   repository = "https://charts.jenkins.io"
#   chart      = "jenkins"
#   # version    = "3.6.0"
#   namespace  = "jenkins"
#   timeout    = 600
#   values = [
#     file("values.yaml"),
#   ]

#   depends_on = [
#     kubernetes_namespace.jenkins
#   ]
# }

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
  
#   depends_on = [
#     aws_eks_addon.efs-csi-driver
#   ]
  
# }

resource "helm_release" "aws_efs_csi_driver" {
  chart      = "aws-efs-csi-driver"
  name       = "aws-efs-csi-driver"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.eu-west-3.amazonaws.com/eks/aws-efs-csi-driver"
  }

  set {
    name  = "controller.serviceAccount.create"
    value = true
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.attach_efs_csi_role.iam_role_arn
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "efs-csi-controller-sa"
  }
}