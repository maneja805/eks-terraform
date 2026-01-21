output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = module.network.private_subnets
}

# output "eks_cluster_id" {
#   description = "ID of the EKS cluster"
#   value       = module.eks_cluster.eks_cluster_id
# }

# output "eks_cluster_endpoint" {
#   description = "Endpoint of the EKS cluster"
#   value       = module.eks_cluster.eks_cluster_endpoint
# }

# output "eks_cluster_security_group_id" {
#   description = "Security group ID of the EKS cluster"
#   value       = module.eks_cluster.eks_cluster_security_group_id
# }