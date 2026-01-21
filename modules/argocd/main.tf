# # ####################################################################################
# # ### ArgoCD Namespace
# # ####################################################################################
# # resource "kubernetes_namespace" "argocd" {
# #   metadata {
# #     name = var.argocd_namespace
# #   }

# #   depends_on = [module.eks]
# # }

data "aws_caller_identity" "current" {}

data "kubernetes_service" "argo_cd_server" {
  metadata {
    name      = "argo-cd-argocd-server"
    namespace = var.argocd_namespace
  }
}

data "aws_secretsmanager_secret_version" "github-secret" {
  secret_id = "github-secret"
}

####################################################################################
### ArgoCD Helm Release
####################################################################################
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_helm_chart_version
  # namespace        = kubernetes_namespace.argocd.metadata[0].name
  namespace        = var.argocd_namespace
  create_namespace = true

  # depends_on = [kubernetes_namespace.argocd]
}

##ArgoCD Helm Bootstrap for installing applications as addons from bootstrap folder
resource "helm_release" "argo_cd_bootstrap" {
  depends_on       = [helm_release.argocd]
  name             = "argocd-bootstrap"
  chart            = "${path.module}/charts/bootstrap"
  namespace        = var.argocd_namespace
  create_namespace = false
  set = [
    {
      name  = "path"
      value = "bootstrap"
    },
    {
      name  = "repoURL"
      value = var.argo_cd_bootstrap_repo_url
    },
    {
      name  = "targetRevision"
      value = var.argo_cd_bootstrap_repo_branch
    }

  ]
}

resource "kubernetes_secret" "argocd_credentials" {
  metadata {
    name      = "declaritive-creds"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    githubAppID             = trimspace(base64decode(jsondecode(data.aws_secretsmanager_secret_version.github-secret.secret_string)["github_app_id"]))
    githubAppInstallationID = trimspace(base64decode(jsondecode(data.aws_secretsmanager_secret_version.github-secret.secret_string)["github_app_installation_id"]))
    githubAppPrivateKey     = base64decode(jsondecode(data.aws_secretsmanager_secret_version.github-secret.secret_string)["github_app_private_key"])
    url                     = "https://github.com/maneja-private/argocd-addons.git"
  }
  depends_on = [helm_release.argocd]
}

resource "kubernetes_secret" "argocd_in_cluster" {
  metadata {
    name      = "in-cluster"
    namespace = "argocd"
    labels = merge({
      "argocd.argoproj.io/secret-type" = "cluster"
    }, var.config.addons)
    annotations = var.config.annotations
  }

  data = {
    name   = "in-cluster"
    server = "https://kubernetes.default.svc"
  }
  depends_on = [helm_release.argocd]
}