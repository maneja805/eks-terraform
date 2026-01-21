provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network" # Path to the module directory

  aws_region         = var.aws_region
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  tags               = local.tags
}

module "eks" {
  source = "./modules/eks" # Path to the eks module

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.private_subnets
  min_size           = var.min_size
  max_size           = var.max_size
  desired_size       = var.desired_size
  instance_types     = var.instance_types
  tags               = local.tags
  principal_arns     = ["arn:aws:iam::943294494093:role/aws-reserved/sso.amazonaws.com/ap-south-1/AWSReservedSSO_PowerUserAccess_2b37abd49295dc42"]
  depends_on         = [module.network]

}

# Argocd server
module "argo_cd" {
  source                    = "./modules/argocd"
  argocd_helm_chart_version = "7.3.3"
  depends_on                = [module.eks]
  config                    = local.argocd

}

module "external_dns" {
  source        = "./modules/external-dns"
  oidc_provider = module.eks.oidc_provider_arn
  cluster_name  = module.eks.cluster_name
  tags          = local.tags
  depends_on    = [module.eks]
}

module "lb_pod_identity" {
  source            = "./modules/tf-aws-lb-controller"
  oidc_provider_arn = module.eks.oidc_provider_arn
  cluster_name      = module.eks.cluster_name
  tags              = local.tags
  depends_on        = [module.eks]

}

module "external_secret" {
  source       = "./modules/external-secrets"
  cluster_name = module.eks.cluster_name
  tags         = local.tags
  depends_on   = [module.eks]
}

module "platform_namespaces" {
  source              = "./modules/platform-bootstrap"
  cluster_name        = module.eks.cluster_name
  tags                = local.tags
  platform_namespaces = local.platform_namespaces
  depends_on          = [module.eks]
}
