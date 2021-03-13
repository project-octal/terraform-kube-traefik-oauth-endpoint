resource "random_password" "middleware_oauth_cookie_secret" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_secret" "middleware_oauth" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/component" : local.component
      "app.kubernetes.io/part-of" : var.part_of
    }, var.labels)
  }
  data = {
    client_secret = var.oauth_client_secret
    cookie_secret = random_password.middleware_oauth_cookie_secret.result
  }
}