variable "cluster_name" {
  type        = string
  description = "A Custom name for the EKS cluster"
}

variable "external_secrets_cluster_service_account" {
  description = "The name of the service account used for the ClusterSecretStore"
  default     = "external-secrets"
}

variable "external_secrets_cluster_secrets_namespace" {
  description = "The name of the Kubernetes namespace for the ClusterSecretStore"
  default     = "external-secrets"
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default     = {}
}