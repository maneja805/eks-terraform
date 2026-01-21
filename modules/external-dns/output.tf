output "external_dns_role_arn" {
  value       = module.external_dns_irsa.arn
  description = "External-DNS IRSA role ARN"
}

output "irsa_arn" {
  description = "ARN of External-DNS"
  value       = module.external_dns_irsa.arn
}

output "irsa_name" {
  description = "Name of External-DNS"
  value       = module.external_dns_irsa.name
}

output "irsa_path" {
  description = "Path of External-DNS"
  value       = module.external_dns_irsa.path
}

output "irsa_unique_id" {
  description = "Unique ID of External-DNS"
  value       = module.external_dns_irsa.unique_id
}

################################################################################
# IAM Policy
################################################################################

output "irsa_iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.external_dns_irsa.iam_policy_arn
}

output "irsa_iam_policy" {
  description = "The policy document"
  value       = module.external_dns_irsa.iam_policy
}