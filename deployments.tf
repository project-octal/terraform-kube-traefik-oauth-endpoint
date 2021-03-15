module "traefik_oauth_endpoint" {
  source = "github.com/project-octal/terraform-kubernetes-deployment"

  name      = var.name
  namespace = var.namespace
  part_of   = var.part_of
  component = local.component
  labels    = var.labels

  containers = [{
    name              = "oauth"
    image_repository  = "registry.hub.docker.com"
    image_name        = "funkypenguin/traefik-forward-auth"
    image_tag         = "latest"
    image_pull_policy = "Always"
    is_init           = false
    ports = [{
      container_port = 4181
    }]
    simple_environment_variables = {
      "AUTH_HOST"     = var.oauth_host
      "COOKIE_DOMAIN" = var.oauth_cookie_domain
      "CLIENT_ID"     = var.oauth_client_id
      "OIDC_ISSUER"   = var.oauth_oidc_issuer
      "LOG_LEVEL"     = "debug"
    }
    secret_environment_variables = {
      "CLIENT_SECRET" = {
        name = kubernetes_secret.middleware_oauth.metadata[0].name
        key  = "client_secret"
      }
      "SECRET" = {
        name = kubernetes_secret.middleware_oauth.metadata[0].name
        key  = "cookie_secret"
      }
    }
  }]
}