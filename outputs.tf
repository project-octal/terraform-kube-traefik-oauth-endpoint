# my-svc.my-namespace.svc.cluster-domain.example
output "oauth_endpoint" {
  value = "${kubernetes_service.middleware_oauth_service.metadata[0].name}.${kubernetes_service.middleware_oauth_service.metadata[0].namespace}.svc"
}