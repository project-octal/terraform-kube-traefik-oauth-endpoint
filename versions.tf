terraform {
  required_version = ">= 0.14"

  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}