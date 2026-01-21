locals {
  default_tags = {
    Environment = "poc"
    ManagedBy   = "Terraform"
  }
  vpc_name_pattern = var.vpc_name != "" ? var.vpc_name : "${var.cluster_name}-vpc"

  tags = merge(local.default_tags, var.tags)
  environment_mapping = {
    "sb"   = "sb",
    "dev"  = "nonp",
    "sit"  = "nonp",
    "nft"  = "nonp",
    "uat"  = "nonp",
    "prod" = "prod"
  }
  infrastructure_environment = local.environment_mapping[var.environment]
  dns_domain                 = format("%s.%s.%s", var.cluster_name, local.infrastructure_environment, try(var.custom_domain, "eks.iam.poc"))

  argocd = {
    addons = {
      enable_external_dns = var.enable_external_dns
    }
    annotations = merge(
      {
        dns_domain          = local.dns_domain
        cluster_name        = var.cluster_name
        vpc_id              = data.aws_vpc.cluster_vpc.id
        region              = var.aws_region
        platform_namespaces = local.argocd_platform_namespaces
        account_id          = data.aws_caller_identity.current.account_id
        aws_region          = data.aws_region.current.name

      },
    )
  }
  # platform namespace to create the IRSA for all namespace and secret store to manage the secrets from AWS

  platform_namespaces = {
    "github-arc-runner" = {
      secrets_manager_access = true
    }
  }

  # Add default limits to platform namespaces for ArgoCD
  argocd_platform_namespaces = jsonencode({
    for name, config in local.platform_namespaces : name => merge(config, {
      cpu_limits    = lookup(config, "cpu_limits", local.platform_default_cpu_limits)
      memory_limits = lookup(config, "memory_limits", local.platform_default_memory_limits)
      pod_limits    = lookup(config, "pod_limits", local.platform_default_pod_limits)
    })
  })

  platform_default_cpu_limits    = 15
  platform_default_memory_limits = 30
  platform_default_pod_limits    = 50

  default_limits = {
    kargo = {
      memory_limits   = "512Mi"
      cpu_requests    = "50m"
      memory_requests = "128Mi"
    }
    cert_manager = {
      memory_limits   = "64Mi"
      cpu_requests    = "10m"
      memory_requests = "32Mi"
    }
  }


}