resource "kubernetes_deployment" "middleware_oauth_deployment" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name"      = var.name,
      "app.kubernetes.io/component" = local.component,
      "app.kubernetes.io/part-of"   = var.part_of
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        "app.kubernetes.io/name"      = var.name,
        "app.kubernetes.io/component" = local.component,
        "app.kubernetes.io/part-of"   = var.part_of
      }
    }
    template {
      metadata {
        labels = merge({
          "app.kubernetes.io/name"      = var.name,
          "app.kubernetes.io/component" = local.component,
          "app.kubernetes.io/part-of"   = var.part_of
        }, var.labels)
      }
      spec {
        automount_service_account_token = false

        # TODO: Add anti-affinity rule to make sure replicas don't wind up on the same host.

        ### Container ###
        container {
          name              = local.name
          image             = "${local.image_repository}/${local.image_name}:${local.image_tag}"
          image_pull_policy = var.image_pull_policy

          env {
            name  = "AUTH_HOST"
            value = var.oauth_host
          }

          env {
            name  = "COOKIE_DOMAIN"
            value = var.oauth_cookie_domain
          }

          env {
            name  = "CLIENT_ID"
            value = var.oauth_client_id
          }

          env {
            name  = "OIDC_ISSUER"
            value = var.oauth_oidc_issuer
          }

          env {
            name  = "LOG_LEVEL"
            value = var.log_level
          }

          env {
            name = "CLIENT_SECRET"
            value_from {
              secret_key_ref {
                key  = kubernetes_secret.middleware_oauth.metadata[0].name
                name = "client_secret"
              }
            }
          }

          env {
            name = "SECRET"
            value_from {
              secret_key_ref {
                key  = kubernetes_secret.middleware_oauth.metadata[0].name
                name = "cookie_secret"
              }
            }
          }

          # TODO: I'd like to generate a cert so that this internal hop is encrypted.
          port {
            name           = "http"
            protocol       = "TCP"
            container_port = 4181
          }

          resources {
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
        }
      }
    }
  }
}