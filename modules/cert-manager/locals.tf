########################################################
# Local Values for Tag Management
########################################################

locals {
  # Base tags with Name and description for different resource types
  cert_manager_pod_identity_tags = merge(var.tags, {
    Name        = "eks_cert_manager-${var.cluster_name}"
    description = "Pod identity for cert-manager in ${var.cluster_name}"
  })
}