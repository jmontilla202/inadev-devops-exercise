resource "time_sleep" "sleep5s" {
  create_duration = "5s"

  depends_on = [ module.eks.aws_eks_cluster ]
}

# resource "helm_release" "jenkins" {
#   provider = helm

#   name       = "jenkins"
#   repository = "https://charts.jenkins.io"
#   chart      = "jenkins"
#   namespace  = "jenkins"
#   timeout    = 600
#   values = [
#     file("./values.yaml"),
#   ]

#   depends_on = [null_resource.create_jenkins_namespace]
# }

