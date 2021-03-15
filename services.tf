resource "kubernetes_service" "middleware_oauth_service" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = merge({
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/component" : local.component
      "app.kubernetes.io/part-of" : var.part_of
    }, var.labels)
  }
  spec {
    selector = {
      "app.kubernetes.io/name" : var.name
      "app.kubernetes.io/component" : local.component
      "app.kubernetes.io/part-of" : var.part_of
    }
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 80
      target_port = 4181
    }
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = 4181
    }
  }
}