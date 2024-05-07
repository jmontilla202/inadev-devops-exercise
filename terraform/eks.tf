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
      desired_size = 3
      min_size     = 2
      max_size     = 5

      labels = {
        role = "spot"
      }

      # taints = [{
      #   key    = "market"
      #   value  = "spot"
      #   effect = "NO_SCHEDULE"
      # }]

      instance_types = ["t3a.medium"]
      capacity_type  = "SPOT"
    }
  }

# iam_role_additional_policies = {"
# {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Federated": "arn:aws:iam::916222977025:oidc-provider/oidc.eks.us-east-2.amazonaws.com/id/7F3067831AC4116D6B5EB95AA1E06E57"
#         },
#         "Action": "sts:AssumeRoleWithWebIdentity",
#         "Condition": {
#           "StringEquals": {
#             "oidc.eks.us-east-2.amazonaws.com/id/7F3067831AC4116D6B5EB95AA1E06E57:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
#           }
#         }
#       }
#     ]
#   }"}



  tags = {
    Environment = "dev"
  }
}

output "oidc_provider" {
  value = module.eks.oidc_provider
}

# output "cluster_role_arn" {
#   value = module.eks.cluster_iam_role_arn
# }

# output "cluster_role_name" {
#   value = module.eks.cluster_iam_role_name
# }

# module "eks-efs-csi-driver" {
#   source  = "lablabs/eks-efs-csi-driver/aws"
#   version = "0.1.2"

#   # insert the 2 required variables here
#   cluster_identity_oidc_issuer = module.eks.oidc_provider
#   cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
# }