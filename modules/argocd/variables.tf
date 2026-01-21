variable "argocd_namespace" {
  description = "The namespace where ArgoCD will be deployed"
  type        = string
  default     = "argocd"

}

variable "argocd_helm_chart_version" {
  type        = string
  description = "Helm chart version of ArgoCD"
}

variable "domain_name" {
  description = "The domain name for Route53 hosted zone"
  type        = string
  default     = "eks.iam.poc"

}

variable "argo_cd_bootstrap_repo_url" {
  description = "value for ArgoCD bootstrap repository URL"
  type        = string
  default     = "https://github.com/maneja-private/argocd-addons.git"
}

variable "argo_cd_bootstrap_repo_branch" {
  description = "value for ArgoCD bootstrap repository branch"
  type        = string
  default     = "main"

}

variable "config" {
  description = "Configuration map for ArgoCD"
  type        = any

}