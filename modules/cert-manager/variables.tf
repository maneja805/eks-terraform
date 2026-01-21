variable "region" {
  type        = string
  description = "AWS region where resources are spinned up"
}
variable "cluster_name" {
  type        = string
  description = "A Custom name for the EKS cluster"
}

variable "oidc_provider_arn" {
  type        = string
  description = "OIDC provider ARN associated with EKS cluster"
}

variable "cert_manager_namespace" {
  type        = string
  default     = "cert-manager"
  description = "Kubernetes namespace for cert-manager"
}

variable "cert_manager_service_account" {
  type        = string
  default     = "cert-manager"
  description = "Service account name for the cert-manager"
}

variable "certificate_authority_arn" {
  type        = string
  description = "The AWS PCA for signing private certificates."
  default     = "arn:aws:acm-pca:eu-west-2:091635179671:certificate-authority/c969bdd4-6f2c-4bc5-8ef3-de4382cef2ab"
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default     = {}
}