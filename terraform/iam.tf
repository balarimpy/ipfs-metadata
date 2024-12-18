module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.0"

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  create_role = true

  role_name         = "eks-cluster-role"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
}
