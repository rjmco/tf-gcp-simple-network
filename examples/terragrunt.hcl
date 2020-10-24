locals {
  google_providers_version = "3.44.0"
}

generate "providers" {
  path      = "tg_gen_providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "${local.google_providers_version}"
    }
  }
}
EOF
}