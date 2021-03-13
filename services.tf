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
      port        = 4181
      target_port = 80
    }
  }
}