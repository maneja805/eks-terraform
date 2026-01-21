data "aws_route53_zone" "selected" {
  name         = "eks.iam.poc." # Note the trailing dot
  private_zone = true           # Set to true if it's a private zone
}


module "external_dns_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"
  version = "6.2.3"

  name                          = "external-dns-${var.cluster_name}"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = [data.aws_route53_zone.selected.arn]

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider
      namespace_service_accounts = ["external-dns:external-dns"]
    }
  }

  tags = local.external_dns_role_tags
}
