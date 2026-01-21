########################################################
# Local Values for Tag Management
########################################################

locals {
  # Create namespace-specific tags for IRSA roles
  ext_secret_namespace_role_tags = {
    for ns in keys(var.platform_namespaces) : ns => {
      for k, v in merge(var.tags, {
        Name        = "${var.cluster_name}_${ns}_secrets_manager"
        description = "POD Identity to access namespace secret ${ns} in ${var.cluster_name}"
      }) : k => tostring(v) # This ensures every value is a string
    }
  }



  # Create namespace-specific tags for Secrets Manager policies
  # secrets_manager_policy_tags = {
  #   for ns in keys(var.platform_namespaces) : ns => merge(var.tags, {
  #     Name        = "${var.cluster_name}_${ns}_secrets_manager"
  #     description = "Secrets Manager policy for platform namespace ${ns} in ${var.cluster_name}"
  #   })
  # }
  secrets_manager_policy_tags = {
    for ns in keys(var.platform_namespaces) : ns => {
      for k, v in merge(var.tags, {
        Name        = "${var.cluster_name}_${ns}_secrets_manager"
        description = "Secrets Manager policy for platform namespace ${ns} in ${var.cluster_name}"
      }) : k => tostring(v) # This ensures every value is a string
    }
  }
}