########################################################
# Local Values for Tag Management
########################################################

locals {
  # Base tags with Name and description for different resource types
  external_secret_iam_role_tags = merge(var.tags, {
    Name        = "eks_external_secrets_${var.cluster_name}"
    description = "IAM role for External Secrets in ${var.cluster_name}"
  })

  secrets_manager_policy_tags = merge(var.tags, {
    Name        = "${var.cluster_name}_eks_secrets_manager"
    description = "Policy to allow the ${var.cluster_name} to access Cluster-wide scoped AWS Secrets Manager Secrets"
  })
}
