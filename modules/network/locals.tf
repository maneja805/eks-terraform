locals {
  default_tags = {
    ManagedBy = "Terraform"
  }

  tags = merge(local.default_tags, var.tags)
}