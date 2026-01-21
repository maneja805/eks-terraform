output "cert_manager_role_arn" {
  value       = module.cert_manager_pod_identity.iam_role_arn
  description = "Cert Manager IRSA role ARN"
}