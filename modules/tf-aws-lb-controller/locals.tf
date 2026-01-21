########################################################
# Local Values for Tag Management
########################################################

locals {
  # Base tags with Name and description for different resource types
  lb_iam_role_tags = merge(var.tags, {
    Name        = "eks_lb_controller_${var.cluster_name}"
    description = "IAM role for AWS Load Balancer Controller in ${var.cluster_name}"
  })
}
