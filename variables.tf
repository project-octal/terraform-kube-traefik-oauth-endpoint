variable "name" {
  type        = string
  description = "The name of this ingress route"
}
variable "part_of" {
  type        = string
  description = "The service this middleware belongs to"
}
variable "namespace" {
  type        = string
  description = "The name of the namespace this ingress route will reside in"
}
variable "labels" {
  type        = map(string)
  description = "A map of string to add to use as the labels for this resource"
}

####################
## OAUTH Settings ##
####################
variable "oauth_host" {
  type        = string
  description = "The FQDN to use for your auth host"
}
variable "oauth_cookie_domain" {
  type        = string
  description = "The root FQDN of your domain"
}
variable "oauth_client_id" {
  type        = string
  description = "Your keycloak client name"
}
variable "oauth_client_secret" {
  type        = string
  description = "Your keycloak client secret"
}
variable "oauth_oidc_issuer" {
  type        = string
  description = "https://<your keycloak URL>/auth/realms/master"
}
variable "oauth_secret" {
  type        = string
  description = "A random string to secure your cookie"
}