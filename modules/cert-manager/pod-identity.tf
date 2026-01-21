##############################
# Cert-Manager POD Identity
#############################

module "cert_manager_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.5.0"

  name                 = "cert_manager-${var.cluster_name}"
  use_name_prefix      = false
  attach_custom_policy = true

  associations = {
    cert_manager = {
      namespace       = var.cert_manager_namespace
      service_account = var.cert_manager_service_account
      cluster_name    = var.cluster_name
    }
  }

  policy_statements = [
    {
      sid = "ACMPCA"
      actions = [
        "acm-pca:DescribeCertificateAuthority",
        "acm-pca:IssueCertificate",
        "acm-pca:GetCertificate",
        "acm-pca:ListPermissions"
      ]
      resources = [var.certificate_authority_arn]
    }
  ]

  tags = local.cert_manager_pod_identity_tags
}