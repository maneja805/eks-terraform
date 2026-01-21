output "aws_lb_controller_role_arn" {
  value       = module.lb_pod_identity.iam_role_arn
  description = "AWS Load Balancer Controller IRSA role ARN"
}