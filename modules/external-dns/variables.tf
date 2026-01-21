variable "oidc_provider" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "Tags for AWS resources"
  default     = {}
}