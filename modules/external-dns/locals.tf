########################################################
# Local Values for Tag Management
########################################################

locals {
  # Base tags with Name and description for different resource types
  external_dns_role_tags = merge(var.tags, {
    Name        = "external-dns-operator-${var.cluster_name}"
    description = "IAM role for External DNS operator in ${var.cluster_name}"
  })
}