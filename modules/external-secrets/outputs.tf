output "external_secrets_iam_role_arn" {
  description = "The ARN of the IAM role created for External Secrets"
  value       = module.external_secret_pod_identity.iam_role_arn
}

output "external_secrets_iam_role_name" {
  description = "The name of the IAM role created for External Secrets"
  value       = module.external_secret_pod_identity.iam_role_name
}

output "external_secrets_association_id" {
  description = "The ID of the EKS Pod Identity association"
  # This returns a map if you have multiple associations
  value = module.external_secret_pod_identity.associations
}