locals {
  profile      = "inodev-exercise"
  cluster_name = "inodev-coding-exercise"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"    ]
    principals  {
      type = "Federated"
      identifiers = [module.eks.oidc_provider_arn]
    }
  }
}

resource "aws_iam_role" "eks_ebs_csi_driver_role" {
  name               = "eks-ebs-csi-driver-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  depends_on = [ module.vpc ]
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  role       = aws_iam_role.eks_ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  depends_on = [ module.vpc ]
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

  depends_on = [module.vpc]
}

resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name = local.cluster_name
  addon_name   = "aws-ebs-csi-driver"
  depends_on = [module.eks.aws_eks_cluster]
  service_account_role_arn = aws_iam_role.eks_ebs_csi_driver_role.arn
}
