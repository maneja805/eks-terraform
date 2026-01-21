################################################################################
# External Secrets - POD Identity
################################################################################

module "external_secret_pod_identity" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "~> 2.6.0"

  name = "eks-ext-secrets-${var.cluster_name}"

  # This attaches the specific LBC policy automatically
  # attach_external_secrets_policy = true
  additional_policy_arns = {
    secrets_manager = aws_iam_policy.secrets_manager_policy.arn
  }

  # This creates the "Association" that was blank before
  associations = {
    main = {
      cluster_name    = var.cluster_name
      namespace       = var.external_secrets_cluster_secrets_namespace
      service_account = var.external_secrets_cluster_service_account
    }
  }

  tags = local.external_secret_iam_role_tags
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "${var.cluster_name}_eks_secrets_manager"
  description = "Policy to allow the ${var.cluster_name} to access Cluster-wide scoped AWS Secrets Manager Secrets"
  policy = templatefile("${path.module}/templates/secretsmanager_cluster_iam_policy.json", {
    account_id   = data.aws_caller_identity.current.account_id
    cluster_name = var.cluster_name
  })

  tags = local.secrets_manager_policy_tags
}