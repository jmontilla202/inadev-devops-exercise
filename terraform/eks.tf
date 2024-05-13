locals {
  profile      = "inodev-exercise"
  cluster_name = "inodev-coding-exercise"
  # kubeconfig   = "~/.kube/config"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "inodev-coding-exercise"
  cluster_version = var.eks_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    # node_group1 = {
    #   desired_size = 1
    #   min_size     = 1
    #   max_size     = 2

    #   labels = {
    #     role = "general"
    #   }

    #   instance_types = ["t3a.medium"]
    #   capacity_type  = "ON_DEMAND"
    # }

    node_group_spot = {
      desired_size = 2
      min_size     = 1
      max_size     = 3

      labels = {
        role = "spot"
      }

      instance_types = ["t3a.medium"]
      capacity_type  = "SPOT"
    }
  }
  tags = {
    Environment = "dev"
  }
}

resource "null_resource" "kubectl_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name inodev-coding-exercise --alias inodev-exercise"
  }
  depends_on = [ module.eks.aws_eks_cluster ]
}