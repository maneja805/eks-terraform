output "platform_namespace_role_arns" {
  value       = { for ns, role in module.external_secret_pod_identity : ns => role.iam_role_arn }
  description = "ARNs for each role created for each platform namespace"
}