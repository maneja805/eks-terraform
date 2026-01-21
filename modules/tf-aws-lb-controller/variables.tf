variable "cluster_name" {
  type        = string
  description = "A Custom name for the EKS cluster"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN associated with EKS cluster"
}

variable "lb_service_account" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "Service account name for the LoadBalancer Controller"
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default     = {}
}