# output "argo_cd_endpoint" {
#   value = {
#     load_balancer_hostname = try(data.kubernetes_service.argo_cd_server.status[0].load_balancer[0].ingress[0].hostname, null)
#   }
#   description = "The ArgoCD server endpoint"
# }