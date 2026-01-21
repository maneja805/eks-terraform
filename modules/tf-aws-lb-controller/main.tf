################################################################################
# AWS Loadbalancer Controller - Supporting Resources
################################################################################

# module "lb_iam_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version = "5.59.0"

#   role_name                              = "eks_lb_controller_${var.cluster_name}"
#   attach_load_balancer_controller_policy = true

#   oidc_providers = {
#     main = {
#       provider_arn               = var.oidc_provider_arn
#       namespace_service_accounts = ["aws-load-balancer-controller:${var.lb_service_account}"]
#     }
#   }

#   tags = local.lb_iam_role_tags
# }

module "lb_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "~> 2.6.0"

  name = "eks-lb-controller-${var.cluster_name}"

  # This attaches the specific LBC policy automatically
  attach_aws_lb_controller_policy = true

  # This creates the "Association" that was blank before
  associations = {
    main = {
      cluster_name    = var.cluster_name
      namespace       = "aws-load-balancer-controller"
      service_account = "aws-load-balancer-controller"
    }
  }

  tags = local.lb_iam_role_tags
}