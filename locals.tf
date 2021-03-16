locals {
  name             = "oauth"
  component        = "traefik-middleware-oauth"
  image_repository = "registry.hub.docker.com"
  image_name       = "funkypenguin/traefik-forward-auth"
  image_tag        = "latest"
}