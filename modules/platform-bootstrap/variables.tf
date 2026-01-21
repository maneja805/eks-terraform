variable "cluster_name" {
  type        = string
  description = "A Custom name for the EKS cluster"
}

variable "tags" {
  description = "Tags for the AWS resources to get added when the resources spin up"
}

variable "platform_namespaces" {
  description = "The names and configuration of the platform namespaces the EKS cluster require for Add-ons or Helm deployments"
  type = map(object({
    secrets_manager_access                 = optional(bool, false)
    rds_postgres_db                        = optional(list(string), [])
    rds_postgres_user                      = optional(list(string), [])
    s3_bucket_names                        = optional(list(string), [])
    bedrock_foundational_model_product_ids = optional(list(string), [])
    kms_key_ids                            = optional(list(string), [])
    cpu_limits                             = optional(number, 15)
    memory_limits                          = optional(number, 30)
    pod_limits                             = optional(number, 50)
  }))
}