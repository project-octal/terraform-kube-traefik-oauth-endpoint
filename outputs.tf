output "oauth_endpoint" {
  value = kubernetes_service.middleware_oauth_service.metadata[0].name
}