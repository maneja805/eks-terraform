output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS cluster endpoint"
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_certificate_authority_data
}


output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "EKS OIDC provider ARN"
}

output "oidc_provider" {
  value       = module.eks.oidc_provider
  description = "EKS cluster provider"
}

# output "kms_key_arn" {
#   value       = module.ebs_kms_key.key_arn
#   description = "The KMS Key ARN for EKS"
# }

# output "kms_key_id" {
#   value       = module.ebs_kms_key.key_id
#   description = "The KMS Key ID for EKS"
# }

# output "cluster_iam_role_arn" {
#   value       = module.eks.cluster_iam_role_arn
#   description = "The IAM role ARN for EKS"
# }

# output "cluster_security_group_id" {
#   value       = module.eks.cluster_security_group_id
#   description = "The security group ID for EKS"
# }

# output "node_iam_role_arn" {
#   value       = module.eks.node_iam_role_arn
#   description = "The IAM role ARN for the node group"
# }

# output "node_iam_role_name" {
#   value       = module.eks.eks_managed_node_groups["karpenter"].iam_role_name
#   description = "The IAM role name for the node group"
# }

# output "node_group_security_group_id" {
#   value       = module.eks.node_security_group_id
#   description = "The security group ID for the node group"
# }

# output "karpenter_controller_iam_role_arn" {
#   value       = module.karpenter.iam_role_arn
#   description = "The IAM role ARN for the Karpenter controller"
# }

# output "event_rules" {
#   value       = module.karpenter.event_rules
#   description = "Map of the event rules created and their attributes"
# }

# output "sqs_queue_name" {
#   value       = module.karpenter.queue_name
#   description = "The Name of the SQS queue used by Karpenter"
# }

# output "cluster_service_cidr" {
#   value       = module.eks.cluster_service_cidr
#   description = "The CIDR block where Kubernetes pod and service IP addresses are assigned from"
# }
