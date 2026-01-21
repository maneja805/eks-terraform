##########################################################################################################################
# eks application bootstrap - Module to create a multi-purpose IAM Role for IRSA per application namespace in the cluster
##########################################################################################################################

module "external_secret_pod_identity" {
  source   = "terraform-aws-modules/eks-pod-identity/aws"
  version  = "~> 2.6.0"
  for_each = var.platform_namespaces

  # name        = "eks-ext-secrets-${each.key}-${var.cluster_name}"
  name        = substr("eks-ext-sec-${each.key}-${var.cluster_name}", 0, 20)
  description = "Role to allow ${each.key} in the ${var.cluster_name} EKS Cluster"

  # This attaches the specific LBC policy automatically
  # attach_external_secrets_policy = true
  additional_policy_arns = merge(
    lookup(each.value, "secrets_manager_access", false) ? {
      secrets_manager = aws_iam_policy.secrets_manager_policy[each.key].arn
    } : {}
  )

  associations = {
    main = {
      cluster_name    = var.cluster_name
      namespace       = "${each.key}"
      service_account = "${each.key}"
    }
  }

  tags = local.ext_secret_namespace_role_tags[each.key]
}



# Create role to grant appropriate secrets manager permissions for each platform namespace
resource "aws_iam_policy" "secrets_manager_policy" {
  for_each = { for ns, config in var.platform_namespaces : ns => config if lookup(config, "secrets_manager_access", false) }

  name        = "${var.cluster_name}_${each.key}_secrets_manager"
  description = "Policy to allow the ${each.key} namespace to access appropriate AWS Secrets Manager Secrets in the ${var.cluster_name} EKS Cluster"
  policy = templatefile("${path.module}/templates/secretsmanager_namespace_iam_policy.json", {
    account_id   = data.aws_caller_identity.current.account_id
    cluster_name = var.cluster_name
    namespace    = each.key
  })
  tags = local.secrets_manager_policy_tags[each.key]
}